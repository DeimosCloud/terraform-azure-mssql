terraform {
  required_version = ">= 0.12"

  required_providers {
    azurerm = ">= 2.1.0"
    local   = ">= 1.2"
    random  = ">= 2.1"
  }
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
  sqlserver_name = var.server_name == "" ? "server-${var.database_name}" : var.server_name
  # Name of virtual network rule for sql server
  vnet_rule_name = var.vnet_rule_name == "" ? "vnet-rule-${var.database_name}" : var.vnet_rule_name
  # Admin login name
  admin_login_name = var.admin_login_name == "" ? "admin-${random_id.this.hex}" : var.admin_login_name
}

# MSSQL Server
resource "azurerm_mssql_server" "sqlserver" {
  name                          = local.sqlserver_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  administrator_login           = local.admin_login_name
  administrator_login_password  = random_string.this.result
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}

# MSSQL Virtual Network Rule
resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  count               = var.subnet_id == "" ? 0 : 1 # Create virtual network rule only if subnet is specified
  name                = local.vnet_rule_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.sqlserver.name
  subnet_id           = var.subnet_id
}


# MSSQL Database
resource "azurerm_mssql_database" "mssql_database" {
  name        = var.database_name
  server_id   = azurerm_mssql_server.sqlserver.id
  max_size_gb = var.max_size_gb

  tags = var.tags
}
