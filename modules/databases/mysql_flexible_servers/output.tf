output "id" {
  value = mysql_flexible_servers.mysql.id
}

output "fqdn" {
  value = mysql_flexible_servers.mysql.fqdn
}

output "rbac_id" {
  value = try(mysql_flexible_servers.mysql.identity[0].principal_id, null)
}

output "identity" {
  value = try(mysql_flexible_servers.mysql.identity, null)
}

output "name" {
  value = mysql_flexible_servers.mysql.name
}


output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}
