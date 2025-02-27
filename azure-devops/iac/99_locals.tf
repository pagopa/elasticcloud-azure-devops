locals {
  prefix              = "paymon"
  subscription_suffix = "pay-monitoring"
  location            = "italynorth"
  location_short      = "itn"

  azuredevops_project_name = "paymon-iac"

  dev_subscription_name  = "dev-${local.subscription_suffix}"
  uat_subscription_name  = "uat-${local.subscription_suffix}"
  prod_subscription_name = "prod-${local.subscription_suffix}"

  dev_identity_rg_name  = "${local.prefix}-d-${local.location_short}-azdo-identity-rg"
  uat_identity_rg_name  = "${local.prefix}-u-${local.location_short}-azdo-identity-rg"
  prod_identity_rg_name = "${local.prefix}-p-${local.location_short}-azdo-identity-rg"

  prod_key_vault_azdo_rg   = "${local.prefix}-p-itn-azdo-sec-rg"
  prod_key_vault_azdo_name = "${local.prefix}-p-itn-azdo-kv"

  # Service connections/ End points
  srv_endpoint_github_ro = "azure-devops-github-ro"
  srv_endpoint_github_rw = "azure-devops-github-rw"
  srv_endpoint_github_pr = "azure-devops-github-pr"

  domains = concat(
    local.paymon_pipelines,      // common components
    local.product_pipelines
    # local.pagopa_core_pipelines, // pagopa core components
    # local.pagopa_app_pipelines   // pagopa app components
  )

  domain_variables = {}

  target_variables = {
    "pagopa" = {
      TF_POOL_NAME_DEV  = "pagopa-dev-linux-infra",
      TF_POOL_NAME_UAT  = "pagopa-uat-linux-infra",
      TF_POOL_NAME_PROD = "pagopa-prod-linux-infra",
      TF_USE_AKS_SECOND = true
    }
  }

  app_pipeline_permission = {
    "pagopa" = {
      project_name = "pagoPA-iac"
      team_name    = "pagoPA-iac Team"
    }
  }

}
