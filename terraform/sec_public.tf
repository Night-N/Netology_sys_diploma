# -------------------------------------------------------------------------------
# --------------------------------SECURITY:--------------------------------------
# -------------------------------------------------------------------------------

resource "yandex_vpc_security_group" "public-network" {
  name        = "public-network"
  description = "public-network: world access to services"
  network_id  = yandex_vpc_network.network-1.id
  ingress {
    protocol            = "ANY"
    description         = "Allow incoming HTTP traffic for nginx"
    v4_cidr_blocks      = ["0.0.0.0/0",]
    port                = 443
  }
  ingress {
    protocol            = "ANY"
    description         = "Allow incoming HTTP traffic for nginx"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 80
  }
  ingress {
    protocol            = "ANY"
    description         = "Allow alb healthchecks"
    predefined_target   = "loadbalancer_healthchecks"
    from_port           = 1
    to_port             = 65535
  }
}