# -------------------------------------------------------------------------------
# --------------------------------SECURITY:--------------------------------------
# -------------------------------------------------------------------------------

resource "yandex_vpc_security_group" "bastion-network" {
  name        = "bastion-network"
  description = "bastion-network: ssh access to project"
  network_id  = yandex_vpc_network.network-1.id
 
  ingress {
    protocol            = "ANY"
    description         = "Allow incoming SSH traffic"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 22
  } 
  ingress {
    protocol            = "ANY"
    description         = "Allow project access to ELK repo"
    v4_cidr_blocks      = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
    port                = 80
  } 
} 
