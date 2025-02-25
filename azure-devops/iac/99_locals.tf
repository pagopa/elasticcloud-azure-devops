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

  paymon_pipelines = [
    {
      name : "devops",
      target : "paymon"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "devops",
      pipeline_path : "elastic\\00-devops",
      repository : {
        yml_prefix_name = "org-secret"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "elastic-organization-secret",
      target : "paymon"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "elastic-organization-secret",
      pipeline_path : "elastic\\00-organization-secret",
      repository : {
        yml_prefix_name = "org-secret"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "elastic-organization",
      target : "paymon"
      envs : ["p"], #only production environment is available for organization
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "elastic-organization",
      pipeline_path : "elastic\\01-elastic-organization",
      repository : {
        yml_prefix_name = "elastic-org"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "state-storage",
      target : "paymon"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "state-storage",
      pipeline_path : "elastic\\02-state-storage",
      repository : {
        yml_prefix_name = "state-storage"
        branch_name     = "refs/heads/aks-pipeline"
      }
    }

  ]

  pagopa_pipelines = [
    {
      name : "pagopa-az-application",
      target : "pagopa"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : false, # unable to apply because it need PIM permission
      pipeline_prefix : "az-application",
      pipeline_path : "pagopa\\03-az-application",
      repository : {
        yml_prefix_name = "az-app"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "pagopa-deployment",
      target : "pagopa"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "elastic-deployment",
      pipeline_path : "pagopa\\04-elastic-deployment",
      repository : {
        yml_prefix_name = "elastic-deployment"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "pagopa-secret",
      target : "pagopa"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "elastic-secret",
      pipeline_path : "pagopa\\05-elastic-secret",
      repository : {
        yml_prefix_name = "elastic-secret"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "pagopa-resources-common",
      target : "pagopa"
      envs : ["d"],
      regions = ["weu", "itn"]
      kv_name : "paymon-%s-pagopa-%s-kv",
      rg_name : "paymon-%s-pagopa-%s-sec-rg",
      code_review : true,
      deploy : true,
      pipeline_prefix : "pagopa-resources-common",
      pipeline_path : "pagopa\\06-resources-common",
      repository : {
        yml_prefix_name = "res-common"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "pagopa-resources-deployment",
      target : "pagopa"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "pagopa-resources-deployment",
      pipeline_path : "pagopa\\06-resources-deployment",
      repository : {
        yml_prefix_name = "elastic-resource-deployment"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
    {
      name : "pagopa-resources-app",
      target : "pagopa"
      envs : ["d"],
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "pagopa-resources-app",
      pipeline_path : "pagopa\\07-resources-app",
      repository : {
        yml_prefix_name = "res-app"
        branch_name     = "refs/heads/aks-pipeline"
      }
    }
  ]


  domains = concat(
    local.paymon_pipelines, // common components
    local.pagopa_pipelines  // pagopa components
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

}
