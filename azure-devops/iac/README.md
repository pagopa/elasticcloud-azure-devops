<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.116 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___devops_v0__"></a> [\_\_devops\_v0\_\_](#module\_\_\_devops\_v0\_\_) | git::https://github.com/pagopa/azuredevops-tf-modules.git | 7e23d73d22e7b37352c25a32cc40f6f42b6569ea |
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4.git | 876158038b03d7a82ea437c56591154ab504d725 |
| <a name="module_dev_azurerm_iac_deploy_service_conn"></a> [dev\_azurerm\_iac\_deploy\_service\_conn](#module\_dev\_azurerm\_iac\_deploy\_service\_conn) | ./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated | n/a |
| <a name="module_dev_azurerm_iac_plan_service_conn"></a> [dev\_azurerm\_iac\_plan\_service\_conn](#module\_dev\_azurerm\_iac\_plan\_service\_conn) | ./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated | n/a |
| <a name="module_dev_secrets"></a> [dev\_secrets](#module\_dev\_secrets) | ./.terraform/modules/__v3__/key_vault_secrets_query | n/a |
| <a name="module_iac_code_review"></a> [iac\_code\_review](#module\_iac\_code\_review) | ./.terraform/modules/__devops_v0__/azuredevops_build_definition_code_review | n/a |
| <a name="module_prod_azurerm_iac_deploy_service_conn"></a> [prod\_azurerm\_iac\_deploy\_service\_conn](#module\_prod\_azurerm\_iac\_deploy\_service\_conn) | ./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated | n/a |
| <a name="module_prod_azurerm_iac_plan_service_conn"></a> [prod\_azurerm\_iac\_plan\_service\_conn](#module\_prod\_azurerm\_iac\_plan\_service\_conn) | ./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated | n/a |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | ./.terraform/modules/__v3__/key_vault_secrets_query | n/a |
| <a name="module_uat_azurerm_iac_deploy_service_conn"></a> [uat\_azurerm\_iac\_deploy\_service\_conn](#module\_uat\_azurerm\_iac\_deploy\_service\_conn) | ./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated | n/a |
| <a name="module_uat_azurerm_iac_plan_service_conn"></a> [uat\_azurerm\_iac\_plan\_service\_conn](#module\_uat\_azurerm\_iac\_plan\_service\_conn) | ./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated | n/a |

## Resources

| Name | Type |
|------|------|
| [azuredevops_check_approval.environments](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_environment.environments](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_serviceendpoint_github.azure_devops_github_pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure_devops_github_ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure_devops_github_rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azurerm_role_assignment.dev_apply_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dev_plan_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.prod_apply_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.prod_plan_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.uat_apply_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.uat_plan_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuredevops_group.admin](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscriptions.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |
| [azurerm_subscriptions.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |
| [azurerm_subscriptions.uat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pipeline_environments"></a> [pipeline\_environments](#input\_pipeline\_environments) | List of environments pipeline to create | `list(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
