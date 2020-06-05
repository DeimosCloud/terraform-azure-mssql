variable "database_name" {
  description = "The name of the Ms SQL Database. Changing this forces a new resource to be created."
}

variable "subnet_id" {
  description = "The ID of the subnet that the SQL server will be connected to"
}

variable "tags" {
  description = "Tags to be passed to created instances"
  default     = {}
}

variable "resource_group_name" {
  description = "The name of the resource group where the SQL server resides"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "server_version" {
  description = "The version of the MSSQL server."
  default     = "12.0"
}

variable "max_size_gb" {
  description = "the max size of the database in gigabytes."
  default     = 20
}

variable "admin_login_name" {
  description = "The administrator login name for the SQL Server"
  default     = ""
}

variable "server_name" {
  description = "The name of the server to be created"
  default     = ""
}

variable "vnet_rule_name" {
  description = "The name of the SQL virtual network rule to be created"
  default     = ""
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server"
  default     = false
}
