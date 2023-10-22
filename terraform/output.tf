
# -------------------------------------------------------------------------------
# --------------------------------OUTPUT:----------------------------------------
# -------------------------------------------------------------------------------

output "INTERNAL_IP_VM1_NGINX" {
  value = yandex_compute_instance.nginx["vm1-nginx"].network_interface.0.ip_address
}
output "INTERNAL_IP_VM2_NGINX" {
  value = yandex_compute_instance.nginx["vm2-nginx"].network_interface.0.ip_address
}
output "INTERNAL_IP_VM3_ZABBIX_SERVER" {
  value = yandex_compute_instance.vm3-zabbix-server.network_interface.0.ip_address
}
output "INTERNAL_IP_VM4_ZABBIX_FRONT" {
  value = yandex_compute_instance.vm4-zabbix-front.network_interface.0.ip_address
}
output "INTERNAL_IP_VM5_ELASTICSEARCH" {
  value = yandex_compute_instance.vm5-elasticsearch.network_interface.0.ip_address
}
output "INTERNAL_IP_VM6_KIBANA" {
  value = yandex_compute_instance.vm6-kibana.network_interface.0.ip_address
}
output "INTERNAL_IP_VM7_PG" {
  value = yandex_compute_instance.vm7-pg.network_interface.0.ip_address
}
output "INTERNAL_IP_VM8_PG" {
  value = yandex_compute_instance.vm8-pg.network_interface.0.ip_address
}
output "INTERNAL_IP_VM9_PG" {
  value = yandex_compute_instance.vm9-pg.network_interface.0.ip_address
}
output "INTERNAL_IP_VM10_BASTION" {
  value = yandex_compute_instance.vm10-bastion.network_interface.0.ip_address
}
output "EXTERNAL_IP_VM3_ZABBIX_SERVER" {
  value = yandex_compute_instance.vm3-zabbix-server.network_interface.0.nat_ip_address
}
output "EXTERNAL_IP_VM4_ZABBIX_FRONT" {
  value = yandex_compute_instance.vm4-zabbix-front.network_interface.0.nat_ip_address
}
output "EXTERNAL_IP_VM10_BASTION" {
  value = yandex_compute_instance.vm10-bastion.network_interface.0.nat_ip_address
}
output "INTERNAL_IP_NLB2" {
  value = element([
    for listener in yandex_lb_network_load_balancer.nlb2.listener :
    element(listener.internal_address_spec.*.address, 0)
  ], 0)
}