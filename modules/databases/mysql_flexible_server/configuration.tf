resource "time_sleep" "server_configuration" {
  depends_on = [azurerm_mysql_flexible_server.mysql]

  create_duration = "120s"
}

resource "azurerm_postgresql_mysql_server_configuration" "mysql" {
  depends_on = [time_sleep.server_configuration]
  for_each   = try(var.settings.mysql_configurations, {})

  name      = each.value.name
  server_id = azurerm_mysql_flexible_server.mysql.id
  value     = each.value.value
}
