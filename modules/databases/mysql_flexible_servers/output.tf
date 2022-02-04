output "id" {
  value = azurerm_mysql_flexible_server.mysql.id
}

output "fqdn" {
  value = azurerm_mysql_flexible_server.mysql.fqdn
}

output "rbac_id" {
  value = try(azurerm_mysql_flexible_server.mysql.identity[0].principal_id, null)
}

output "identity" {
  value = try(azurerm_mysql_flexible_server.mysql.identity, null)
}

output "name" {
  value = azurerm_mysql_flexible_server.mysql.name
}


output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}
