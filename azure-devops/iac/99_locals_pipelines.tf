locals {
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
        branch_name     = "refs/heads/main"
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
        branch_name     = "refs/heads/main"
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
        branch_name     = "refs/heads/main"
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
        branch_name     = "refs/heads/main"
      }
    }
  ]

  pagopa_core_pipelines = [
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
      pipeline_path : "pagopa\\core\\03-az-application",
      repository : {
        yml_prefix_name = "az-app"
        branch_name     = "refs/heads/main"
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
      pipeline_path : "pagopa\\core\\04-elastic-deployment",
      repository : {
        yml_prefix_name = "elastic-deployment"
        branch_name     = "refs/heads/main"
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
      pipeline_path : "pagopa\\core\\05-elastic-secret",
      repository : {
        yml_prefix_name = "elastic-secret"
        branch_name     = "refs/heads/main"
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
      pipeline_path : "pagopa\\core\\06-resources-deployment",
      repository : {
        yml_prefix_name = "elastic-resource-deployment"
        branch_name     = "refs/heads/main"
      }
    }
  ]

  pagopa_app_pipelines = [
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
      pipeline_path : "pagopa\\app\\06-resources-common",
      repository : {
        yml_prefix_name = "res-common"
        branch_name     = "refs/heads/main"
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
      pipeline_path : "pagopa\\app\\07-resources-app",
      repository : {
        yml_prefix_name = "res-app"
        branch_name     = "refs/heads/main"
      }
    }
  ]
}