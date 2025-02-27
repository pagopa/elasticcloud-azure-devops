locals {
  /*
    ADD PRODUCTS HERE
   */
  products = {
    pagopa : {
      deployment : "pagopa",
      regions : ["weu", "itn"],
      envs : ["d"]
    }
  }

  # static pipelines
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

  # product pipelines generated
  product_pipelines = flatten([for product_key, product_conf in local.products : [
    {
      name : "${product_key}-az-application",
      target : "${product_key}"
      envs : product_conf.envs,
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : false, # unable to apply because it need PIM permission
      pipeline_prefix : "${product_key}-az-application",
      pipeline_path : "${product_key}\\core\\03-az-application",
      repository : {
        yml_prefix_name = "az-app"
        branch_name     = "refs/heads/main"
      }
    },
    {
      name : "${product_key}-deployment",
      target : "${product_conf.deployment}"
      envs : product_conf.envs,
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "${product_key}-elastic-deployment",
      pipeline_path : "${product_key}\\core\\04-elastic-deployment",
      repository : {
        yml_prefix_name = "elastic-deployment"
        branch_name     = "refs/heads/main"
      }
    },
    {
      name : "${product_key}-secret",
      target : "${product_key}"
      envs : product_conf.envs,
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "${product_key}-elastic-secret",
      pipeline_path : "${product_key}\\core\\05-elastic-secret",
      repository : {
        yml_prefix_name = "elastic-secret"
        branch_name     = "refs/heads/main"
      }
    },
    {
      name : "${product_key}-resources-deployment",
      target : "${product_conf.deployment}"
      envs : product_conf.envs,
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "${product_key}-resources-deployment",
      pipeline_path : "${product_key}\\core\\06-resources-deployment",
      repository : {
        yml_prefix_name = "elastic-resource-deployment"
        branch_name     = "refs/heads/main"
      }
    },
    {
      name : "${product_key}-resources-common",
      target : "${product_key}"
      envs : product_conf.envs,
      regions = product_conf.regions,
      kv_name : "paymon-%s-${product_key}-%s-kv",
      rg_name : "paymon-%s-${product_key}-%s-sec-rg",
      code_review : true,
      deploy : true,
      pipeline_prefix : "${product_key}-resources-common",
      pipeline_path : "${product_key}\\app\\06-resources-common",
      repository : {
        yml_prefix_name = "res-common"
        branch_name     = "refs/heads/main"
      }
    },
    {
      name : "${product_key}-resources-app",
      target : "${product_key}"
      envs : product_conf.envs,
      regions = []
      kv_name : "",
      rg_name : "",
      code_review : true,
      deploy : true,
      pipeline_prefix : "${product_key}-resources-app",
      pipeline_path : "${product_key}\\app\\07-resources-app",
      repository : {
        yml_prefix_name = "res-app"
        branch_name     = "refs/heads/main"
      }
    }
  ]])

}