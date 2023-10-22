# -------------------------------------------------------------------------------
# -------------------------------ELK:--------------------------------------------
# -------------------------------------------------------------------------------
resource "yandex_compute_instance" "vm5-elasticsearch" {
  name                      = "vm5-elasticsearch"
  hostname                  = "vm5-elasticsearch"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  resources {
    core_fraction           = 20
    cores                   = 2
    memory                  = 8
  }
  boot_disk {
    initialize_params {
      image_id              = "fd84itfojin92kj38vmb"
      size                  = 15
      type                  = "network-ssd"
    }
  }
  network_interface {
    subnet_id               = yandex_vpc_subnet.subnets["subnet-a"].id
    nat                     = false
    security_group_ids      = [yandex_vpc_security_group.private-network.id]
  }
  metadata = {
    user-data               = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible             = true 
  }
}

resource "yandex_compute_instance" "vm6-kibana" {
  name                      = "vm6-kibana"
  hostname                  = "vm6-kibana"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  resources {
    core_fraction           = 20
    cores                   = 2
    memory                  = 4
  }
  boot_disk {
    initialize_params {
      image_id              = "fd84itfojin92kj38vmb"
      size                  = 15
      type                  = "network-ssd"
    }
  }
  network_interface {
    subnet_id               = yandex_vpc_subnet.subnets["subnet-a"].id
    nat                     = false
    security_group_ids      = [yandex_vpc_security_group.private-network.id]
  }
  metadata = {
    user-data               = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible             = true
  }
}

# -------------------------------------------------------------------------------
# -------------------------------Zabbix:-----------------------------------------
# -------------------------------------------------------------------------------
resource "yandex_compute_instance" "vm3-zabbix-server" {
  name                      = "vm3-zabbix-server"
  hostname                  = "vm3-zabbix-server"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  resources {
    core_fraction           = 20
    cores                   = 2
    memory                  = 4
  }
  boot_disk {
    initialize_params {
      image_id              = "fd84itfojin92kj38vmb"
      size                  = 10
      type                  = "network-ssd"
    }
  }
  network_interface {
    subnet_id               = yandex_vpc_subnet.subnets["subnet-a"].id
    nat                     = false
    security_group_ids      = [yandex_vpc_security_group.private-network.id]
  }
  metadata = {
    user-data               = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible             = true 
  }
}

resource "yandex_compute_instance" "vm4-zabbix-front" {
  name                      = "vm4-zabbix-front"
  hostname                  = "vm4-zabbix-front"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  resources {
    core_fraction           = 20
    cores                   = 2
    memory                  = 2
  }
  boot_disk {
    initialize_params {
      image_id              = "fd84itfojin92kj38vmb"
      size                  = 10
      type                  = "network-ssd"
    }
  }
  network_interface {
    subnet_id               = yandex_vpc_subnet.subnets["subnet-a"].id
    nat                     = false
    security_group_ids      = [yandex_vpc_security_group.private-network.id]
  }
  metadata = {
    user-data               = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible             = true 
  }
}