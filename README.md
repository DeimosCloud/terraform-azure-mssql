# MSSQL Azure
A terraform module  for MSSQL Database creation


## Basic Usage 

```hcl
module "mssql" {
  source = "git::https://gitlab.com/deimosdev/tooling/terraform-modules/terraform-mssql-azure"

  database_name       = "test"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location

  tags = {
    environment = "TEST"
    costcenter  = "it"
    managed     = "terraform"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | >= 2.1.0 |
| local | >= 1.2 |
| random | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.1.0 |
| random | >= 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_login\_name | The administrator login name for the SQL Server | `string` | `""` | no |
| database\_name | The name of the Ms SQL Database. Changing this forces a new resource to be created. | `any` | n/a | yes |
| location | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| max\_size\_gb | the max size of the database in gigabytes. | `number` | `20` | no |
| public\_network\_access\_enabled | Whether or not public network access is allowed for this server | `bool` | `false` | no |
| resource\_group\_name | The name of the resource group where the SQL server resides | `any` | n/a | yes |
| server\_name | The name of the server to be created | `string` | `""` | no |
| server\_version | The version of the MSSQL server. | `string` | `"12.0"` | no |
| subnet\_id | The ID of the subnet that the SQL server will be connected to. If specified, a virtual network rule is created for server. The subnet should have the Microsoft.Sql service endpoint enabled | `string` | `""` | no |
| tags | Tags to be passed to created instances | `map` | `{}` | no |
| vnet\_rule\_name | The name of the SQL virtual network rule to be created | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| server\_administrator\_login | Administrator Login username |
| server\_administrator\_login\_password | Administration login password |
| server\_id | The id of the server the MSSQL database was provisioned on |
| server\_name | The name of the server the MSSQL database was provisioned on |
| subnet\_id | The ID of the subnet that the SQL server is connected to. |
| vnet\_rule\_id | The ID of the SQL virtual network rule |

