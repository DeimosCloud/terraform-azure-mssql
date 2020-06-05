output "server_administrator_login" {
  description = "Administrator Login username"
  value       = azurerm_mssql_server.sqlserver.administrator_login
}

output "server_administrator_login_password" {
  description = "Administration login password"
  value       = azurerm_mssql_server.sqlserver.administrator_login_password
}

output "server_name" {
  description = "The name of the server the MSSQL database was provisioned on "
  value       = azurerm_mssql_server.sqlserver.name
}

output "server_id" {
  description = "The id of the server the MSSQL database was provisioned on "
  value       = azurerm_mssql_server.sqlserver.id
}

output "subnet_id" {
  description = "The ID of the subnet that the SQL server is connected to."
  value       = azurerm_sql_virtual_network_rule.sqlvnetrule.subnet_id
}

output "vnet_rule_id" {
  description = "The ID of the SQL virtual network rule"
  value       = azurerm_sql_virtual_network_rule.sqlvnetrule.subnet_id
}


