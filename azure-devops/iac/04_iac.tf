locals {
  default_repository = {
    organization   = "pagopa"
    name           = "elasticcloud-infra"
    branch_name    = "refs/heads/main"
    pipelines_path = ".devops"
  }

  code_review_domains = [for d in local.domains : d if d.code_review == true]
  deploy_domains      = [for d in local.domains : d if d.deploy == true]

  base_iac_variables = {
    #PLAN
    TF_AZURE_SERVICE_CONNECTION_PLAN_NAME_DEV  = module.dev_azurerm_iac_plan_service_conn.service_endpoint_name,
    TF_AZURE_SERVICE_CONNECTION_PLAN_NAME_UAT  = module.uat_azurerm_iac_plan_service_conn.service_endpoint_name,
    TF_AZURE_SERVICE_CONNECTION_PLAN_NAME_PROD = module.prod_azurerm_iac_plan_service_conn.service_endpoint_name,
    #APPLY
    TF_AZURE_SERVICE_CONNECTION_APPLY_NAME_DEV  = module.dev_azurerm_iac_deploy_service_conn.service_endpoint_name,
    TF_AZURE_SERVICE_CONNECTION_APPLY_NAME_UAT  = module.uat_azurerm_iac_deploy_service_conn.service_endpoint_name,
    TF_AZURE_SERVICE_CONNECTION_APPLY_NAME_PROD = module.prod_azurerm_iac_deploy_service_conn.service_endpoint_name,
  }

  # code review vars
  base_iac_variables_code_review = {}
  # code review secrets
  base_iac_variables_secret = {}
  # deploy vars
  base_iac_variables_deploy = {}
}

###################################################
## HOW TO DEFINE A PIPELINE FOR A NEW DOMAIN?     #
## have a look at README.md                       #
###################################################
module "iac_code_review" {
  source = "./.terraform/modules/__devops_v0__/azuredevops_build_definition_code_review"

  for_each = { for d in local.code_review_domains : d.name => d }
  path     = each.value.pipeline_path

  project_id                   = data.azuredevops_project.project.id
  repository                   = merge(local.default_repository, each.value.repository)
  github_service_connection_id = azuredevops_serviceendpoint_github.azure_devops_github_pr.id

  pipeline_name_prefix = each.value.pipeline_prefix

  variables = merge(
    local.base_iac_variables,
    contains(each.value.envs, "d") && try(each.value.kv_name, "") != "" ? {
      tf_dev_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[0]}-dev-aks-apiserver-url"].value,
      tf_dev_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[0]}-dev-aks-azure-devops-sa-cacrt"].value,
      tf_dev_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[0]}-dev-aks-azure-devops-sa-token"].value),
      tf_dev_aks_name                  = "${each.value.target}-d-${each.value.regions[0]}-dev-aks"
    } : {},
    contains(each.value.envs, "d") && try(each.value.kv_name, "") != "" && length(each.value.regions) > 1 ? {
      tf_second_dev_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[1]}-dev-aks-apiserver-url"].value,
      tf_second_dev_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[1]}-dev-aks-azure-devops-sa-cacrt"].value,
      tf_second_dev_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[1]}-dev-aks-azure-devops-sa-token"].value),
      tf_second_dev_aks_name                  = "${each.value.target}-d-${each.value.regions[1]}-dev-aks"
    } : {},

    contains(each.value.envs, "u") && try(each.value.kv_name, "") != "" ? {
      tf_uat_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[0]}-uat-aks-apiserver-url"].value,
      tf_uat_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[0]}-uat-aks-azure-devops-sa-cacrt"].value,
      tf_uat_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[0]}-uat-aks-azure-devops-sa-token"].value),
      tf_uat_aks_name                  = "${each.value.target}-u-${each.value.regions[0]}-uat-aks"
    } : {},
    contains(each.value.envs, "u") && try(each.value.kv_name, "") != "" && length(each.value.regions) > 1 ? {
      tf_second_uat_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[1]}-uat-aks-apiserver-url"].value,
      tf_second_uat_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[1]}-uat-aks-azure-devops-sa-cacrt"].value,
      tf_second_uat_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[1]}-uat-aks-azure-devops-sa-token"].value),
      tf_second_uat_aks_name                  = "${each.value.target}-u-${each.value.regions[1]}-uat-aks"
    } : {},

    contains(each.value.envs, "p") && try(each.value.kv_name, "") != "" ? {
      tf_prod_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[0]}-prod-aks-apiserver-url"].value,
      tf_prod_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[0]}-prod-aks-azure-devops-sa-cacrt"].value,
      tf_prod_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[0]}-prod-aks-azure-devops-sa-token"].value),
      tf_prod_aks_name              = "${each.value.target}-p-${each.value.regions[0]}-prod-aks"
    } : {},
    contains(each.value.envs, "p") && try(each.value.kv_name, "") != "" && length(each.value.regions) > 1 ? {
      tf_second_prod_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[1]}-prod-aks-apiserver-url"].value,
      tf_second_prod_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[1]}-prod-aks-azure-devops-sa-cacrt"].value,
      tf_second_prod_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[1]}-prod-aks-azure-devops-sa-token"].value),
      tf_second_prod_aks_name                  = "${each.value.target}-p-${each.value.regions[1]}-prod-aks"
    } : {},
    {
      tf_target = each.value.target
    },
    local.base_iac_variables_code_review,
    try(local.domain_variables[each.value.name].iac_variables, {}),
    try(local.target_variables[each.value.target], {}),
    try(local.domain_variables[each.value.name].iac_variables_cr, {})
  )

  variables_secret = merge(
    local.base_iac_variables_secret,
    try(local.domain_variables[each.value.name].iac_variables_secrets_cr, {})
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure_devops_github_ro.id,
    module.dev_azurerm_iac_plan_service_conn.service_endpoint_id,
    module.uat_azurerm_iac_plan_service_conn.service_endpoint_id,
    module.prod_azurerm_iac_plan_service_conn.service_endpoint_id,
  ]
}

####################################################
### HOW TO DEFINE A PIPELINE FOR A NEW DOMAIN?     #
### have a look at README.md                       #
####################################################
module "iac_deploy" {
  source = "./.terraform/modules/__devops_v0__/azuredevops_build_definition_deploy"

  for_each = { for d in local.deploy_domains : d.name => d }
  path     = each.value.pipeline_path

  project_id                   = data.azuredevops_project.project.id
  repository                   = merge(local.default_repository, each.value.repository)
  github_service_connection_id = azuredevops_serviceendpoint_github.azure_devops_github_pr.id

  pipeline_name_prefix = each.value.pipeline_prefix

  variables = merge(
    local.base_iac_variables,
    contains(each.value.envs, "d") && try(each.value.kv_name, "") != "" ? {
      tf_dev_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[0]}-dev-aks-apiserver-url"].value,
      tf_dev_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[0]}-dev-aks-azure-devops-sa-cacrt"].value,
      tf_dev_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[0]}-dev-aks-azure-devops-sa-token"].value),
      tf_dev_aks_name                  = "${each.value.target}-d-${each.value.regions[0]}-dev-aks"
    } : {},
    contains(each.value.envs, "d") && try(each.value.kv_name, "") != "" && length(each.value.regions) > 1 ? {
      tf_second_dev_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[1]}-dev-aks-apiserver-url"].value,
      tf_second_dev_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[1]}-dev-aks-azure-devops-sa-cacrt"].value,
      tf_second_dev_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-d-${each.value.regions[1]}-dev-aks-azure-devops-sa-token"].value),
      tf_second_dev_aks_name                  = "${each.value.target}-d-${each.value.regions[1]}-dev-aks"
    } : {},

    contains(each.value.envs, "u") && try(each.value.kv_name, "") != "" ? {
      tf_uat_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[0]}-uat-aks-apiserver-url"].value,
      tf_uat_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[0]}-uat-aks-azure-devops-sa-cacrt"].value,
      tf_uat_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[0]}-uat-aks-azure-devops-sa-token"].value),
      tf_uat_aks_name                  = "${each.value.target}-u-${each.value.regions[0]}-uat-aks"
    } : {},
    contains(each.value.envs, "u") && try(each.value.kv_name, "") != "" && length(each.value.regions) > 1 ? {
      tf_second_uat_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[1]}-uat-aks-apiserver-url"].value,
      tf_second_uat_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[1]}-uat-aks-azure-devops-sa-cacrt"].value,
      tf_second_uat_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-u-${each.value.regions[1]}-uat-aks-azure-devops-sa-token"].value),
      tf_second_uat_aks_name                  = "${each.value.target}-u-${each.value.regions[1]}-uat-aks"
    } : {},

    contains(each.value.envs, "p") && try(each.value.kv_name, "") != "" ? {
      tf_prod_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[0]}-prod-aks-apiserver-url"].value,
      tf_prod_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[0]}-prod-aks-azure-devops-sa-cacrt"].value,
      tf_prod_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[0]}-prod-aks-azure-devops-sa-token"].value),
      tf_prod_aks_name              = "${each.value.target}-p-${each.value.regions[0]}-prod-aks"
    } : {},
    contains(each.value.envs, "p") && try(each.value.kv_name, "") != "" && length(each.value.regions) > 1 ? {
      tf_second_prod_aks_apiserver_url         = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[1]}-prod-aks-apiserver-url"].value,
      tf_second_prod_aks_azure_devops_sa_cacrt = module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[1]}-prod-aks-azure-devops-sa-cacrt"].value,
      tf_second_prod_aks_azure_devops_sa_token = base64decode(module.dev_secrets[each.value.name].values["${each.value.target}-p-${each.value.regions[1]}-prod-aks-azure-devops-sa-token"].value),
      tf_second_prod_aks_name                  = "${each.value.target}-p-${each.value.regions[1]}-prod-aks"
    } : {},
    {
      tf_target = each.value.target
    },
    local.base_iac_variables_deploy,
    try(local.target_variables[each.value.target], {}),
    try(local.domain_variables[each.value.name].iac_variables_deploy, {})
  )

  variables_secret = merge(
    local.base_iac_variables_secret,
    try(local.domain_variables[each.value.name].iac_variables_secrets_deploy, {})
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure_devops_github_ro.id,
    module.dev_azurerm_iac_deploy_service_conn.service_endpoint_id,
    module.uat_azurerm_iac_deploy_service_conn.service_endpoint_id,
    module.prod_azurerm_iac_deploy_service_conn.service_endpoint_id,
  ]
}

resource "azuredevops_build_folder_permissions" "app_pipelin_permission" {
  for_each = local.app_pipeline_permission

  depends_on = [module.iac_code_review, module.iac_deploy]

  project_id = data.azuredevops_project.project.id
  path       = "\\${each.key}\\app"
  principal  = data.azuredevops_group.target_group[each.key].id

  permissions = {
    "ViewBuilds" : "Allow",
    "EditBuildQuality" : "Deny",
    "RetainIndefinitely" : "Allow",
    "DeleteBuilds" : "Deny",
    "ManageBuildQualities" : "Deny",
    "DestroyBuilds" : "Deny",
    "UpdateBuildInformation" : "Deny",
    "QueueBuilds" : "Allow",
    "ManageBuildQueue" : "Deny",
    "StopBuilds" : "Allow",
    "ViewBuildDefinition" : "Allow",
    "EditBuildDefinition" : "Deny",
    "DeleteBuildDefinition" : "Deny",
    "AdministerBuildPermissions" : "NotSet"
  }
}