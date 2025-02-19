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
  #
  #  aks_dev_platform_name  = "p4pa-d-itn-dev-aks"
  #  aks_uat_platform_name  = "p4pa-u-itn-uat-aks"
  #  aks_prod_platform_name = "p4pa-p-itn-prod-aks"
  #
  domains = [
    {
      target : "pagopa"
      name : "pagopa-resources-common",
      envs : ["d"],
      regions = ["weu", "itn"]
      kv_name : "paymon-%s-pagopa-%s-kv",
      rg_name : "paymon-%s-pagopa-%s-sec-rg",
      code_review : true,
      deploy : true,
      pipeline_prefix : "pagopa-resources-common",
      pipeline_path : "elastic\\resources-common",
      repository : {
        yml_prefix_name = "pagopa-res"
        branch_name     = "refs/heads/aks-pipeline"
      }
    },
  ]
  #    {
  #      name : "networking",
  #      envs : ["d", "u", "p"],
  #      kv_name : "",
  #      rg_name : "",
  #      code_review : true,
  #      deploy : true,
  #      pipeline_prefix : "networking-infra",
  #      pipeline_path : "networking-infrastructure",
  #      repository : {
  #        yml_prefix_name : "networking"
  #      }
  #    },
  #    {
  #      name : "security",
  #      envs : ["d", "u", "p"],
  #      kv_name : "",
  #      rg_name : "",
  #      code_review : true,
  #      deploy : true,
  #      pipeline_prefix : "security-infra",
  #      pipeline_path : "security-infrastructure",
  #      repository : {
  #        yml_prefix_name : "security"
  #      }
  #    },
  #    {
  #      name : "packer",
  #      envs : ["d", "u", "p"],
  #      kv_name : "",
  #      rg_name : "",
  #      code_review : true,
  #      deploy : true,
  #      pipeline_prefix : "packer-infra",
  #      pipeline_path : "packer-infrastructure",
  #      repository : {
  #        yml_prefix_name : "packer"
  #      }
  #    },
  #    {
  #      name : "core",
  #      envs : ["d", "u", "p"],
  #      kv_name : "",
  #      rg_name : "",
  #      code_review : true,
  #      deploy : true,
  #      pipeline_prefix : "core-infra",
  #      pipeline_path : "core-infrastructure",
  #      repository : {
  #        yml_prefix_name : "core"
  #      }
  #    },
  #    {
  #      name : "monitoring",
  #      envs : ["d", "u", "p"],
  #      kv_name : "",
  #      rg_name : "",
  #      code_review : true,
  #      deploy : true,
  #      pipeline_prefix : "monitoring-infra",
  #      pipeline_path : "monitoring-infrastructure",
  #      repository : {
  #        yml_prefix_name : "monitoring"
  #      }
  #    },
  #    {
  #      name : "platform",
  #      envs : ["d", "u", "p"],
  #      kv_name : "",
  #      rg_name : "",
  #      code_review : true,
  #      deploy : true,
  #      pipeline_prefix : "platform-infra",
  #      pipeline_path : "platform-infrastructure",
  #      repository : {
  #        yml_prefix_name : "platform"
  #      }
  #    },
  #    {
  #      name : "payhub-api-spec",
  #      envs : ["d", "u", "p"],
  #      kv_name : "",
  #      rg_name : "",
  #      code_review : true,
  #      deploy : true,
  #      pipeline_prefix : "payhub-api-spec",
  #      pipeline_path : "payhub-api-spec",
  #      repository : {
  #        name = "p4pa-infra-api-spec"
  #        yml_prefix_name : "payhub"
  #        branch_name = "refs/heads/main"
  #      }
  #    }
  #  ]
  #
  #  domain_variables = {
  #    payhub = {
  #      iac_variables_cr : {},
  #      iac_variables_secrets_cr : {},
  #      iac_variables_deploy : {},
  #      iac_variables_secrets_deploy : {}
  #    }
  #  }

}
