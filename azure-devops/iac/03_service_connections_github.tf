#
# 🐙 GITHUB
#

# Github service connection (read-only)
resource "azuredevops_serviceendpoint_github" "azure_devops_github_ro" {
  depends_on = [data.azuredevops_project.project]

  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_github_ro
  auth_personal {
    personal_access_token = module.secrets.values["azure-devops-github-ro-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description]
  }
}

# Github service connection (pull request)
resource "azuredevops_serviceendpoint_github" "azure_devops_github_pr" {
  depends_on = [data.azuredevops_project.project]

  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_github_pr
  auth_personal {
    personal_access_token = module.secrets.values["azure-devops-github-pr-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}



# Github service connection (read-write)
resource "azuredevops_serviceendpoint_github" "azure_devops_github_rw" {
  depends_on = [data.azuredevops_project.project]

  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_github_rw
  auth_personal {
    personal_access_token = module.secrets.values["azure-devops-github-rw-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}
