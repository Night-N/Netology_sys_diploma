# -------------------------------------------------------------------------------
# -------------------------------SNAPSHOTS:--------------------------------------
# -------------------------------------------------------------------------------

# resource "yandex_compute_snapshot_schedule" "default" {
#   name           = "snapshot"

#   schedule_policy {
#   expression = "0 0 ? * *"
#   }

#   snapshot_count = 7

#   snapshot_spec {
#     description = "snapshot-description"
#     labels = {
#       snapshot-label = "my-snapshot-label-value"
#     }
#   }

#   labels = {
#     my-label = "my-label-value"
#   }

#   disk_ids = [yandex_compute_instance.vm1-nginx.boot_disk.0.disk_id,
#               yandex_compute_instance.vm2-nginx.boot_disk.0.disk_id,
#               yandex_compute_instance.vm3-zabbix-server.boot_disk.0.disk_id,
#               yandex_compute_instance.vm4-zabbix-front.boot_disk.0.disk_id,
#               yandex_compute_instance.vm5-elasticsearch.boot_disk.0.disk_id,
#               yandex_compute_instance.vm6-kibana.boot_disk.0.disk_id,
#               yandex_compute_instance.vm7-pg.boot_disk.0.disk_id,
#               yandex_compute_instance.vm8-pg.boot_disk.0.disk_id,
#               yandex_compute_instance.vm9-pg.boot_disk.0.disk_id]
# }