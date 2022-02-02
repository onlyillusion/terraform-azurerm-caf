


resource "azurerm_mysql_flexible_server_database" "mysql" {
  depends_on = [azurerm_mysql_flexible_server.mysql]
  for_each   = try(var.settings.mysql_databases, {})

  name      = azurerm_mysql_flexible_server_database[each.key].result
  server_id = azurerm_mysql_flexible_server.mysql.id
  collation = try(each.value.collation, "en_US.utf8")
  charset   = try(each.value.charset, "utf8")
}

resource "azurerm_key_vault_secret" "mysql_database_name" {
  for_each = { for key, value in var.settings.mysql_databases : key => value if can(var.settings.keyvault) }

  name         = format("%s-ON-%s", each.value.name, azurerm_mysql_flexible_server.mysql_flexible_server.name)
  value        = each.value.name
  key_vault_id = var.remote_objects.keyvault_id
}

