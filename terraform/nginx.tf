# -------------------------------------------------------------------------------
# -------------------------------NGINX:------------------------------------------
# -------------------------------------------------------------------------------
resource "yandex_compute_instance" "vm1-nginx" {
  name                      = "vm1-nginx"
  hostname                  = "vm1-nginx"
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
    subnet_id               = yandex_vpc_subnet.subnet-a.id
    nat                     = false
    security_group_ids      = [yandex_vpc_security_group.private-network.id, yandex_vpc_security_group.public-network.id]
  }
  metadata = {
    user-data               = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible             = true 
  }
}

resource "yandex_compute_instance" "vm2-nginx" {
  name                      = "vm2-nginx"
  hostname                  = "vm2-nginx"
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"
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
    subnet_id               = yandex_vpc_subnet.subnet-b.id
    nat                     = false
    security_group_ids      = [yandex_vpc_security_group.private-network.id, yandex_vpc_security_group.public-network.id]
  }
  metadata = {
    user-data               = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible             = true
  }
}