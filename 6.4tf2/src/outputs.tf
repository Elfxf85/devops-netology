output "vm_ip_map" {
  value = {
    "yandex_compute_instance.platform.name" = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    "yandex_compute_instance.vm_db.name" = yandex_compute_instance.vm_db.network_interface.0.nat_ip_address
  }
}

output "admin_info" { value = "${local.test_map.admin} is admin for ${local.test_list[length(local.test_list)-1]} server based on OS ${local.servers[local.test_list[length(local.test_list)-1]]["image"]} with ${local.servers[local.test_list[length(local.test_list)-1]]["cpu"]} vcpu, ${local.servers[local.test_list[length(local.test_list)-1]]["ram"]} ram, and ${local.servers.production["disks"][0]}, ${local.servers.production["disks"][1]}, ${local.servers.production["disks"][2]}, ${local.servers.production["disks"][3]} virtual disks" }