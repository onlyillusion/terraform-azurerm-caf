output "mysql_flexible_server" {
  value = module.mysql_flexible_server
}

module "mysql_flexible_server" {
  source     = "./modules/databases/mysql_flexible_server"
  depends_on = [module.keyvaults, module.networking]
  for_each   = local.database.mysql_flexible_server

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key], null),
    try(each.value.resource_group.name, null)
  )

  remote_objects = {
    subnet_id = try(
      local.combined_objects_networking[each.value.vnet.lz_key][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id,
      local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id,
      null
    )

    private_dns_zone_id = try(
      local.combined_objects_private_dns[each.value.private_dns_zone.lz_key][each.value.private_dns_zone.key].id,
      local.combined_objects_private_dns[local.client_config.landingzone_key][each.value.private_dns_zone.key].id,
      null
    )
    keyvault_id  = try(each.value.administrator_password, null) == null ? module.keyvaults[each.value.keyvault_key].id : null
   

    diagnostics = local.combined_diagnostics
  }

}
