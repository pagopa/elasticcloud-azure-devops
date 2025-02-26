#
# AZURE
#

data "azurerm_client_config" "current" {}

data "azurerm_subscriptions" "dev" {
  display_name_prefix = local.dev_subscription_name
}

data "azurerm_subscriptions" "uat" {
  display_name_prefix = local.uat_subscription_name
}
data "azurerm_subscriptions" "prod" {
  display_name_prefix = local.prod_subscription_name
}

#
# DEVOPS
#

data "azuredevops_project" "project" {
  name = local.azuredevops_project_name
}

data "azuredevops_group" "admin" {
  project_id = data.azuredevops_project.project.id
  name       = "admins"
}

data "azuredevops_project" "target_project" {
  for_each = local.app_pipeline_permission
  name = each.value.project_name
}

data "azuredevops_group" "target_group" {
  for_each = local.app_pipeline_permission
  project_id = data.azuredevops_project.target_project[each.key].id
  name       = each.value.team_name
}
