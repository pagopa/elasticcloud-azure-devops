resource "azuredevops_environment" "environments" {
  for_each = toset(var.pipeline_environments)

  project_id = data.azuredevops_project.project.id
  name       = each.key
}

resource "azuredevops_check_approval" "environments" {
  for_each = toset(var.pipeline_environments)

  project_id           = data.azuredevops_project.project.id
  target_resource_id   = azuredevops_environment.environments[each.key].id
  target_resource_type = "environment"

  requester_can_approve = true
  approvers = [
    data.azuredevops_group.admin.origin_id
  ]

  timeout = 120
}
