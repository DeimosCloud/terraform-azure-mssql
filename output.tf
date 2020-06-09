output "database_name" {
  description = "The name of the created database"
  value       = azurerm_mssql_database.mssql_database.name
}

output "server_administrator_login" {
  description = "Administrator Login username"
  value       = azurerm_mssql_server.sqlserver.administrator_login
}

output "server_domain_name" {
  description = "The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net"
  value       = azurerm_mssql_server.sqlserver.fully_qualified_domain_name
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

output "private_link_endpoint_id" {
  description = "The ID of the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint[0].id

  depends_on = [azurerm_private_endpoint.private_endpoint]
}

output "private_link_endpoint_name" {
  description = "The name of the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint[0].name

  depends_on = [azurerm_private_endpoint.private_endpoint]
}

output "private_endpoint_ip_address" {
  description = "The private IP address associated with the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint[0].private_ip_address

  depends_on = [azurerm_private_endpoint.private_endpoint]
}


output "vnet_rule_id" {
  description = "The ID of the SQL virtual network rule"
  value       = azurerm_sql_virtual_network_rule.sqlvnetrule[0].subnet_id

  depends_on = [azurerm_sql_virtual_network_rule.sqlvnetrule]
}
