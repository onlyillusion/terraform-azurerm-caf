resource "azurecaf_name" "mysql_flexible_server_database" {
  for_each = var.settings.mysql_databases

  name          = each.value.name
  resource_type = "azurerm_mysql_flexible_server_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_mysql_flexible_server_database" "mysql" {
  depends_on = [azurerm_mysql_flexible_server.mysql]
  for_each   = try(var.settings.mysql_databases, {})

  name      = azurecaf_name.mysql_flexible_server_database[each.key].result
  server_id = azurerm_mysql_flexible_server.mysql.id
  collation = try(each.value.collation, "en_US.utf8")
  charset   = try(each.value.charset, "utf8")
}

# Store the azurerm_postgresql_flexible_server_database_name into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mysql_database_name" {
  for_each = { for key, value in var.settings.mysql_databases : key => value if can(var.settings.keyvault) }

  name         = format("%s-ON-%s", each.value.name, azurecaf_name.mysql_flexible_server.result)
  value        = each.value.name
  key_vault_id = var.remote_objects.keyvault_id
}
