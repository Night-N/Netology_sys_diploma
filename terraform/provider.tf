provider "http" {
  ca_cert = "/etc/certs/ca.crt"
  skip_cert_verification  = "true"
}
provider "yandex" {
  token     = "${var.yc_token}"
  cloud_id  = "${var.yc_cloud_id}"
  folder_id = "b1g9sr83g7docecpucn7"
  zone      = "ru-central1-a"
}