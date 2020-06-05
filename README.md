# MSSQL Azure
A terraform module  for MSSQL Database creation


## Basic Usage 

```hcl
module "mssql" {
  source = "git::https://gitlab.com/deimosdev/tooling/terraform-modules/terraform-mssql-azure"

  database_name       = "test"
  subnet_id           = var.subnet_id
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location

  tags = {
    environment = "TEST"
    costcenter  = "it"
    managed     = "terraform"
  }
}
```

This creates a `backend.tf` file in the specified `backend_output_path` (default: project directory). Apply the configured backend by running `terraform init` again

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | ~> 2.0.0 |
| local | >= 1.2 |
| null | >= 2.1 |
| random | >= 2.1 |
| template | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.0.0 |
| null | >= 2.1 |
| random | >= 2.1 |
| template | >= 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_output\_path | The default file to output backend configuration to | `string` | `"./backend.tf"` | no |
| container\_name | The Name of the Storage Container within the Storage Account. | `string` | `""` | no |
| key | The name of the Blob used to retrieve/store Terraform's State file inside the Storage Container. | `string` | `"global/terrform.tfstate"` | no |
| location | The location of resource group | `any` | n/a | yes |
| name\_prefix | The prefix for all created resources | `string` | `"tfstate"` | no |
| resource\_group\_name | The Name of the Resource Group in which the Storage Account exists. | `string` | `""` | no |
| storage\_account\_name | The name of the storage account | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| key | The name of the Blob created to retrieve/store Terraform's State file inside the Storage Container |
| resource\_group | Name of created resource group |
| storage\_account | Name of created storage account |
| storage\_container | Name of created storage container |

