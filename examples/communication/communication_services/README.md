# communication_service

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.4.0"
  # insert the 7 required variables here
}
```

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Communication Service resource. Changing this forces a new Communication Service to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data_location| The location where the Communication service stores its data at rest. Possible values are `Asia Pacific`, `Australia`, `Europe`, `UK` and `United States`. Defaults to `United States`.||False|
|tags| A mapping of tags which should be assigned to the Communication Service.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Communication Service.|||
|primary_connection_string|The primary connection string of the Communication Service.|||
|secondary_connection_string|The secondary connection string of the Communication Service.|||
|primary_key|The primary key of the Communication Service.|||
|secondary_key|The secondary key of the Communication Service.|||
