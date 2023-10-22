# -------------------------------------------------------------------------------
# -----------------------------BASTION HOST:-------------------------------------
# -------------------------------------------------------------------------------
resource "yandex_compute_instance" "vm10-bastion" {
  name                      = "vm10-bastion"
  hostname                  = "vm10-bastion"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  boot_disk {
    initialize_params {
      image_id    = "fd89sipsl24rogjo35f1"  #saved image with almalinux+nginx+ELKrepo
      size        = 15
      type        = "network-ssd"
    }
  }
  network_interface {
    subnet_id           = yandex_vpc_subnet.subnets["subnet-pub-a"].id
    nat                 = true
    security_group_ids  = [yandex_vpc_security_group.private-network.id, yandex_vpc_security_group.bastion-network.id ]
  }
  metadata = {
    user-data     = data.template_file.metadata.rendered
  }
  scheduling_policy {
    preemptible   = true
  }

}
