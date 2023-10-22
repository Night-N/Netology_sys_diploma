variable "yc_token" {
  type = string
}
variable "yc_cloud_id" {
  type = string
}
variable "ssh_user" {
  type = string
}
variable "ssh_id" {
  type = string
}
variable "yandex_reserved_ip" {
  type = string
}
variable "yandex_certificate_id" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "network_spec" {
  type = map(object({
    cidr_block = string
    zone = string
  }))
  default = {
    "subnet-pub-a" = {
      "cidr_block" = "192.168.100.0/24"
      "zone" = "ru-central1-a"
    }
    "subnet-a" = {
      "cidr_block" = "192.168.101.0/24"
      "zone" = "ru-central1-a"
    }
    "subnet-b" = {
      "cidr_block" = "192.168.102.0/24"
      "zone" = "ru-central1-b"
    }
    "subnet-c" = {
      "cidr_block" = "192.168.103.0/24"
      "zone" = "ru-central1-c"
    }
  }
  }
variable "nginx_spec" {
  type = map(object({
    name = string
    zone = string
    subnet = string
  }))
  default = {
    "vm1-nginx" = {
      "name" = "vm1-nginx"
      "zone" = "ru-central1-a"
      "subnet" = "subnet-a"
    }
    "vm2-nginx" = {
      "name" = "vm2-nginx"
      "zone" = "ru-central1-b"
      "subnet" = "subnet-b"
    }
  }
  }
  