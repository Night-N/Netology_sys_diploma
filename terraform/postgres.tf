# -------------------------------------------------------------------------------
# -------------------------------POSTGRES:---------------------------------------
# -------------------------------------------------------------------------------
resource "yandex_compute_instance" "vm7-pg" {
  name                      = "vm7-pg"
  hostname                  = "vm7-pg"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }
  boot_disk {
    initialize_params {
      image_id    = "fd84itfojin92kj38vmb"
      size        = 10
      type        = "network-ssd"
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnets["subnet-a"].id
    nat           = false
    security_group_ids  = [yandex_vpc_security_group.private-network.id]
  }
  metadata = {
    user-data     = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible   = true 
  }
}

resource "yandex_compute_instance" "vm8-pg" {
  name                      = "vm8-pg"
  hostname                  = "vm8-pg"
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }
  boot_disk {
    initialize_params {
      image_id    = "fd84itfojin92kj38vmb"
      size        = 10
      type        = "network-ssd"
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnets["subnet-b"].id
    nat           = false
    security_group_ids  = [yandex_vpc_security_group.private-network.id]
  }
  metadata = {
    user-data     = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible   = true
  }
}

resource "yandex_compute_instance" "vm9-pg" {
  name                      = "vm9-pg"
  hostname                  = "vm9-pg"
  platform_id               = "standard-v3"
  zone                      = "ru-central1-c"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }
  boot_disk {
    initialize_params {
      image_id    = "fd84itfojin92kj38vmb"
      size        = 10
      type        = "network-ssd"
    }
  }
  network_interface {
    subnet_id     = yandex_vpc_subnet.subnets["subnet-c"].id
    nat           = false
    security_group_ids  = [yandex_vpc_security_group.private-network.id]
  }
  metadata = {
    user-data     = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible   = true
  }
}