# -------------------------------------------------------------------------------
# --------------------------------SECURITY:--------------------------------------
# -------------------------------------------------------------------------------

resource "yandex_vpc_security_group" "private-network" {
  name        = "private-network"
  description = "private-network: services, ssh and access to internet"
  network_id  = yandex_vpc_network.network-1.id
  egress {
      protocol          = "ANY"
      description       = "Allow outgoing traffic inside project"
      from_port         = 1
      to_port           = 65535
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
    }  

  ingress {
      protocol          = "ANY"
      description       = "Allow SSH traffic in project"
      port              = 22
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow Zabbix traffic in project"
      port              = 10050
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow Zabbix traffic in project"
      port              = 10051
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow load balancer healthcheck patroni"
      port              = 8007
      predefined_target = "loadbalancer_healthchecks"
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow PG traffic in project"
      port              = 8007
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow PG traffic in project"
      port              = 8008
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow ETCD traffic in patroni cluster"
      port              = 2379
      v4_cidr_blocks    = ["192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }
 
  ingress {
      protocol          = "ANY"
      description       = "Allow ETCD traffic in patroni cluster"
      port              = 2380
      v4_cidr_blocks    = ["192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow PG traffic in project"
      port              = 5432
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow PG traffic in project"
      port              = 5431
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow PGbouncer traffic in project"
      port              = 6432
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow PGbouncer traffic in project"
      port              = 6431
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow Elastic RestAPI and node transport"
      from_port         = 9200
      to_port           = 9400
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow Kibana"
      port              = 5601
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow Logstash"
      from_port         = 9600
      to_port           = 9700
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow Beats"
      port              = 5044
      v4_cidr_blocks    = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  }

  ingress {
      protocol          = "ANY"
      description       = "Allow HTTP traffic from nginx to zabbix"
      port              = 8080
      v4_cidr_blocks    = ["192.168.101.0/24", "192.168.102.0/24"]
  }

  egress {
    protocol            = "ANY"
    description         = "Allow outgoing HTTP traffic"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 80
  }
  egress {
    protocol            = "ANY"
    description         = "Allow outgoing HTTP traffic"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 8080
  }
  egress {
    protocol            = "ANY"
    description         = "Allow outgoing HTTPS traffic"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 443
  }
  egress {
    protocol            = "ANY"
    description         = "Allow outgoing DNS traffic"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 53
  }
  egress {
    protocol            = "ANY"
    description         = "Allow outgoing NTP traffic"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 123
  }
  egress {
    protocol            = "ANY"
    description         = "Allow traffic for chronyd"
    v4_cidr_blocks      = ["0.0.0.0/0"]
    port                = 323
  }
}