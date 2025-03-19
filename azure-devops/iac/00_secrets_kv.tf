module "dev_secrets" {
  source = "./.terraform/modules/__v3__/key_vault_secrets_query"

  for_each = { for d in local.domains : d.name => d if contains(d.envs, "d") && try(d.kv_name, "") != "" }

  providers = {
    azurerm = azurerm.dev
  }

  resource_group = format(each.value.rg_name, "d", "dev")
  key_vault_name = format(each.value.kv_name, "d", "dev")

  secrets = flatten([for i in each.value.regions : [
    "${each.value.target}-d-${i}-dev-aks-azure-devops-sa-token",
    "${each.value.target}-d-${i}-dev-aks-azure-devops-sa-cacrt",
    "${each.value.target}-d-${i}-dev-aks-apiserver-url",
  ]])

}

module "uat_secrets" {
  source = "./.terraform/modules/__v3__/key_vault_secrets_query"

  for_each = { for d in local.domains : d.name => d if contains(d.envs, "u") && try(d.kv_name, "") != "" }

  providers = {
    azurerm = azurerm.uat
  }

  resource_group = format(each.value.rg_name, "u", "uat")
  key_vault_name = format(each.value.kv_name, "u", "uat")

  secrets = flatten([for i in each.value.regions : [
    "${each.value.target}-u-${i}-uat-aks-azure-devops-sa-token",
    "${each.value.target}-u-${i}-uat-aks-azure-devops-sa-cacrt",
    "${each.value.target}-u-${i}-uat-aks-apiserver-url",
  ]])
}

module "prod_secrets" {
  source = "./.terraform/modules/__v3__/key_vault_secrets_query"

  for_each = { for d in local.domains : d.name => d if contains(d.envs, "p") && try(d.kv_name, "") != "" }

  providers = {
    azurerm = azurerm.prod
  }

  resource_group = format(each.value.rg_name, "p", "prod")
  key_vault_name = format(each.value.kv_name, "p", "prod")


  secrets = flatten([for i in each.value.regions : [
    "${each.value.target}-p-${i}-prod-aks-azure-devops-sa-token",
    "${each.value.target}-p-${i}-prod-aks-azure-devops-sa-cacrt",
    "${each.value.target}-p-${i}-prod-aks-apiserver-url",
  ]])
}
