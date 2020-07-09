terraform {
  required_version = ">= 0.12"

  required_providers {
    azurerm = ">= 2.1.0"
    local   = ">= 1.2"
    random  = ">= 2.1"
  }
}

data azurerm_resource_group "mssql" {
  name = var.resource_group_name
}

resource "random_id" "this" {
  byte_length = "8"
}

resource "random_string" "this" {
  length  = 16
  special = true
}

locals {
  # Name of SQL Server
  sqlserver_name = var.server_name == "" ? "server-mssql-${random_id.this.hex}" : var.server_name
  # Name of virtual network rule for sql server
  vnet_rule_name = var.vnet_rule_name == "" ? "vnet-rule-mssql-${random_id.this.hex}" : var.vnet_rule_name
  # Admin login name
  admin_login_name = var.admin_login_name == "" ? "admin-${random_id.this.hex}" : var.admin_login_name
  # Private endpoint name
  private_endpoint_name = var.private_endpoint_name == "" ? "private-endpoint-${random_id.this.hex}" : var.private_endpoint_name
}

# MSSQL Server
resource "azurerm_mssql_server" "sqlserver" {
  count                         = var.create_server == true ? 1 : 0
  name                          = local.sqlserver_name
  resource_group_name           = data.azurerm_resource_group.mssql.name
  location                      = data.azurerm_resource_group.mssql.location
  version                       = var.server_version
  administrator_login           = local.admin_login_name
  administrator_login_password  = random_string.this.result
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}


# MSSQL Database
resource "azurerm_mssql_database" "mssql_database" {
  count       = length(var.database_names)
  name        = var.database_names[count.index]
  server_id   = var.server_id == null ? azurerm_mssql_server.sqlserver.0.id : var.server_id
  max_size_gb = var.max_size_gb

  tags = var.tags
}

# Private Endpoint to connect azure subnets to MSSQL server
resource "azurerm_private_endpoint" "private_endpoint" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = local.private_endpoint_name
  location            = data.azurerm_resource_group.mssql.location
  resource_group_name = data.azurerm_resource_group.mssql.name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "privateserviceconnection-${random_id.this.hex}"
    private_connection_resource_id = azurerm_mssql_server.sqlserver.0.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "mssql_fqdn" {
  count               = var.private_dns_zone_name == null ? 0 : 1
  name                = "${local.sqlserver_name}${var.private_fqdn_subdomain}"
  zone_name           = var.private_dns_zone_name
  resource_group_name = data.azurerm_resource_group.mssql.name
  ttl                 = 10
  records             = [azurerm_private_endpoint.private_endpoint[0].private_service_connection[0].private_ip_address]

  depends_on = [azurerm_private_endpoint.private_endpoint]
  tags       = var.tags
}


resource "azurerm_sql_firewall_rule" "azure_service_access" {
  count               = var.allow_access_to_azure_services ? 1 : 0
  name                = "Azure-service-access"
  resource_group_name = data.azurerm_resource_group.mssql.name
  server_name         = local.sqlserver_name
  start_ip_address    = "0.0.0.0" # setting start and end ip to 0.0.0.0 enables azure service access
  end_ip_address      = "0.0.0.0"
}


resource "azurerm_sql_firewall_rule" "clients_ip_rules" {
  count               = length(var.clients_ip)
  name                = "firewall_rule-${var.clients_ip[count.index]["start_ip"]}-${var.clients_ip[count.index]["end_ip"]}"
  resource_group_name = data.azurerm_resource_group.mssql.name
  server_name         = local.sqlserver_name
  start_ip_address    = var.clients_ip[count.index]["start_ip"]
  end_ip_address      = var.clients_ip[count.index]["end_ip"]
}
