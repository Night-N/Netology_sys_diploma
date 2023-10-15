terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
data "template_file" "metadata" {
  template = file("./metadata.tftpl")
  vars = {
    ssh_id             = var.ssh_id
    ssh_user           = var.ssh_user
  }
}