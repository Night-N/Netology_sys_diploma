# -------------------------------------------------------------------------------
# --------------------------------NETWORK:---------------------------------------
# -------------------------------------------------------------------------------

resource "yandex_vpc_network" "network-1" {
  name                      = "network-1"
}

resource "yandex_vpc_default_security_group" "default-sg" {
  description = "Clear default group"
  network_id  = "${yandex_vpc_network.network-1.id}"
}

resource "yandex_vpc_subnet" "subnets" {
  for_each = var.network_spec
  name           = each.key
  zone           = each.value["zone"]
  network_id      = yandex_vpc_network.network-1.id
  route_table_id  = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = [each.value["cidr_block"]]
}

# -------------------------------------------------------------------------------
# -------------------------POSTGRESQL LOAD BALANCER:-----------------------------
# -------------------------------------------------------------------------------

resource "yandex_lb_target_group" "pg-group" {
  name      = "pg-nlb"
  target {
    subnet_id   = yandex_vpc_subnet.subnets["subnet-a"].id
    address     = yandex_compute_instance.vm7-pg.network_interface.0.ip_address
  }
  target {
    subnet_id   = yandex_vpc_subnet.subnets["subnet-b"].id
    address     = yandex_compute_instance.vm8-pg.network_interface.0.ip_address
  }
  target {
    subnet_id   = yandex_vpc_subnet.subnets["subnet-c"].id
    address     = yandex_compute_instance.vm9-pg.network_interface.0.ip_address
  }
}
resource "yandex_lb_network_load_balancer" "nlb2" {
  name                = "nlb2"
  type                = "internal"
  deletion_protection = false
  listener {
    name              = "postgres"
    port              = "5432"
    target_port       = "6431"
    internal_address_spec {
      subnet_id       = yandex_vpc_subnet.subnets["subnet-a"].id
      ip_version      = "ipv4"
    }
  }
  attached_target_group {
    target_group_id       = yandex_lb_target_group.pg-group.id
    healthcheck {
      name                = "patroni-check"
      timeout             = "1"
      interval            = "2"
      unhealthy_threshold = "2" 
      healthy_threshold   = "2" 
        http_options {
          port            = "8007"
          path            = "/master"
        }
    }
  }
}

# -------------------------------------------------------------------------------
# -------------------------NGINX L7 LOAD BALANCER:-------------------------------
# -------------------------------------------------------------------------------

resource "yandex_alb_target_group" "nginx-group" {
  name          = "nginx-alb"
  dynamic "target" {
      for_each = var.nginx_spec
      content {
        subnet_id   = yandex_vpc_subnet.subnets[target.value["subnet"]].id
        ip_address  = yandex_compute_instance.nginx[target.value["name"]].network_interface.0.ip_address    
      }
    }
}

resource "yandex_alb_load_balancer" "alb1" {
  name                  = "alb1"
  network_id            = yandex_vpc_network.network-1.id
  security_group_ids    = [yandex_vpc_security_group.public-network.id, yandex_vpc_security_group.private-network.id]

  allocation_policy {
    location {
      zone_id           = "ru-central1-a"
      subnet_id         = yandex_vpc_subnet.subnets["subnet-a"].id
    }
    location {
      zone_id           = "ru-central1-b"
      subnet_id         = yandex_vpc_subnet.subnets["subnet-b"].id
    }
  }

  listener {
    name = "http-to-https"
    endpoint {
      address {
        external_ipv4_address { 
          address       = "${var.yandex_reserved_ip}"
        }
      }
      ports = [ 80, 8080 ]
    }
    http {
      redirects {
        http_to_https   = true
      }
    }
  }

  listener {
    name = "https"
    endpoint {
      address {
        external_ipv4_address { 
          address       = "${var.yandex_reserved_ip}"
        }
      }
      ports = [ 443 ]
    }
    tls {
      default_handler {
        certificate_ids  = ["${var.yandex_certificate_id}"]
        http_handler {
          http_router_id = yandex_alb_http_router.nginx-router.id
        }
      }
      sni_handler {
        name = "${var.domain_name}"
        server_names = [ "${var.domain_name}" ]
        handler {
          certificate_ids = ["${var.yandex_certificate_id}"]
          http_handler {
            http_router_id = yandex_alb_http_router.nginx-router.id
          }
        }
      }
    }
    
  }
}
# -------------------------------------------------------------------------------
# -------------------------NGINX L7 LOAD BALANCER:-------------------------------
# -------------------------------------------------------------------------------

resource "yandex_alb_http_router" "nginx-router" {
  name          = "nginx-router"
  labels        = {
    tf-label    = "nginx-router"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "nginx-host" {
  name                    = "nginx-host"
  http_router_id          = yandex_alb_http_router.nginx-router.id
  route {
    name                  = "general-route"
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.nginx-backend.id
        timeout           = "60s"
      }
    }
  }
}    

resource "yandex_alb_backend_group" "nginx-backend" {
  name      = "nginx-backend"

  http_backend {
    name = "test-http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_alb_target_group.nginx-group.id}"]
    load_balancing_config {
      panic_threshold = 40
      mode            = "ROUND_ROBIN"
    }    
    healthcheck {
      timeout = "1s"
      interval = "2s"

      http_healthcheck {
        path  = "/"
      }
    }
    http2 = "false"
  }
}
# -------------------------------------------------------------------------------
# -----------------NAT for all VM that don't need their own IP:------------------
# -------------------------------------------------------------------------------

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "route-table"
  network_id = yandex_vpc_network.network-1.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}