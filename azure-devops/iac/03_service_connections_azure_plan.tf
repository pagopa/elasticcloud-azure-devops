#
# ⛩ Service connections
#

module "dev_azurerm_iac_plan_service_conn" {
  source = "./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated"
  providers = {
    azurerm = azurerm.dev
  }

  project_id = data.azuredevops_project.project.id
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  name = "azdo-dev-${local.prefix}-iac-plan"

  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
  subscription_name = local.dev_subscription_name

  location            = local.location
  resource_group_name = local.dev_identity_rg_name
}

resource "azurerm_role_assignment" "dev_plan_permissions" {
  scope                = data.azurerm_subscriptions.dev.subscriptions[0].id
  role_definition_name = "dev-${local.prefix}-platform-iac-reader"
  principal_id         = module.dev_azurerm_iac_plan_service_conn.identity_principal_id
}

#
# UAT
#

module "uat_azurerm_iac_plan_service_conn" {
  source = "./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated"
  providers = {
    azurerm = azurerm.uat
  }

  project_id = data.azuredevops_project.project.id
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  name = "azdo-uat-${local.prefix}-iac-plan"

  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_id   = data.azurerm_subscriptions.uat.subscriptions[0].subscription_id
  subscription_name = local.uat_subscription_name

  location            = local.location
  resource_group_name = local.uat_identity_rg_name
}

resource "azurerm_role_assignment" "uat_plan_permissions" {

  scope                = data.azurerm_subscriptions.uat.subscriptions[0].id
  role_definition_name = "uat-${local.prefix}-platform-iac-reader"
  principal_id         = module.uat_azurerm_iac_plan_service_conn.identity_principal_id
}

#
# PROD
#

module "prod_azurerm_iac_plan_service_conn" {
  source = "./.terraform/modules/__devops_v0__/azuredevops_serviceendpoint_federated"
  providers = {
    azurerm = azurerm.prod
  }

  project_id = data.azuredevops_project.project.id
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  name = "azdo-prod-${local.prefix}-iac-plan"

  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_id   = data.azurerm_subscriptions.prod.subscriptions[0].subscription_id
  subscription_name = local.prod_subscription_name

  location            = local.location
  resource_group_name = local.prod_identity_rg_name
}

resource "azurerm_role_assignment" "prod_plan_permissions" {

  scope                = data.azurerm_subscriptions.prod.subscriptions[0].id
  role_definition_name = "prod-${local.prefix}-platform-iac-reader"
  principal_id         = module.prod_azurerm_iac_plan_service_conn.identity_principal_id
}
