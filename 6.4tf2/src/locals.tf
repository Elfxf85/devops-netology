locals {
  vm1_env = "netology"
  vm1_project = "develop"
  vm1_platform = "platform"
  vm1_role = "web"

  vm2_env = "netology"
  vm2_project = "develop"
  vm2_platform = "platform"
  vm2_role = "db"

  vms = [
    "${local.vm1_env}-${local.vm1_project}-${local.vm1_platform}-${local.vm1_role}",
    "${local.vm2_env}-${local.vm2_project}-${local.vm2_platform}-${local.vm2_role}"
  ]
value = "${local.test_map.admin} is admin for ${local.test_list[length(local.test_list)-1]} server based on OS ${local.servers[local.test_list[length(local.test_list)-1]]["image"]} with ${local.servers[local.test_list[length(local.test_list)-1]]["cpu"]} vcpu, ${local.servers[local.test_list[length(local.test_list)-1]]["ram"]} ram, and ${length(local.servers.production["disks"]) } virtual disks"

}
