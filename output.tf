output "database_names" {
  description = "The name of the created database"
  value       = azurerm_mssql_database.mssql_database.*.name
}

output "server_administrator_login" {
  description = "Administrator Login username"
  value       = var.server_id == null ? azurerm_mssql_server.sqlserver[0].administrator_login : null
}

output "server_domain_name" {
  description = "The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net"
  value       = var.server_id == null ? azurerm_mssql_server.sqlserver[0].fully_qualified_domain_name : null
}

output "server_administrator_login_password" {
  description = "Administration login password"
  value       = var.server_id == null ? azurerm_mssql_server.sqlserver[0].administrator_login_password : null
}

output "server_name" {
  description = "The name of the server the MSSQL database was provisioned on "
  value       = var.server_id == null ? azurerm_mssql_server.sqlserver[0].name : null
}

output "server_id" {
  description = "The id of the server the MSSQL database was provisioned on "
  value       = var.server_id == null ? azurerm_mssql_server.sqlserver[0].id : var.server_id
}

output "private_link_endpoint_id" {
  description = "The ID of the private endpoint"
  value       = var.private_endpoint_name != "" ? azurerm_private_endpoint.private_endpoint[0].id : null
}

output "private_link_endpoint_name" {
  description = "The name of the private endpoint"
  value       = var.private_endpoint_name != "" ? azurerm_private_endpoint.private_endpoint[0].name : null
}

output "private_endpoint_ip_address" {
  description = "The private IP address associated with the private endpoint"
  value       = var.private_endpoint_name != "" ? azurerm_private_endpoint.private_endpoint[0].private_service_connection[0].private_ip_address : null
}

output "private_fqdn" {
  description = "The private FQDN of the SQL Server based on the associated Private Endpoint"
  value       = var.private_dns_zone_name == null ? null : azurerm_private_dns_a_record.mssql_fqdn.0.fqdn
}
