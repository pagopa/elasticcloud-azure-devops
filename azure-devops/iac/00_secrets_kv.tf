##
## aca KEYVAULT
##
#
#module "dev_secrets" {
#  source = "./.terraform/modules/__v3__/key_vault_secrets_query"
#
#  for_each = { for d in local.domains : d.name => d if contains(d.envs, "d") && try(d.kv_name, "") != "" }
#
#  providers = {
#    azurerm = azurerm.dev
#  }
#
#  resource_group = format(each.value.rg_name, "d")
#  key_vault_name = format(each.value.kv_name, "d")
#
#  secrets = [
#    "p4pa-d-itn-dev-aks-azure-devops-sa-token",
#    "p4pa-d-itn-dev-aks-azure-devops-sa-cacrt",
#    "p4pa-d-itn-dev-aks-apiserver-url"
#  ]
#}
#
#module "uat_secrets" {
#  source = "./.terraform/modules/__v3__/key_vault_secrets_query"
#
#  for_each = { for d in local.domains : d.name => d if contains(d.envs, "u") && try(d.kv_name, "") != "" }
#
#  providers = {
#    azurerm = azurerm.uat
#  }
#
#  resource_group = format(each.value.rg_name, "u")
#  key_vault_name = format(each.value.kv_name, "u")
#
#
#  secrets = [
#    "p4pa-u-itn-uat-aks-azure-devops-sa-token",
#    "p4pa-u-itn-uat-aks-azure-devops-sa-cacrt",
#    "p4pa-u-itn-uat-aks-apiserver-url"
#  ]
#}
#
#module "prod_secrets" {
#  source = "./.terraform/modules/__v3__/key_vault_secrets_query"
#
#  for_each = { for d in local.domains : d.name => d if contains(d.envs, "p") && try(d.kv_name, "") != "" }
#
#  providers = {
#    azurerm = azurerm.prod
#  }
#
#  resource_group = format(each.value.rg_name, "p")
#  key_vault_name = format(each.value.kv_name, "p")
#
#
#  secrets = [
#    "p4pa-p-itn-prod-aks-azure-devops-sa-token",
#    "p4pa-p-itn-prod-aks-azure-devops-sa-cacrt",
#    "p4pa-p-itn-prod-aks-apiserver-url"
#  ]
#}
