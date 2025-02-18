terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 1.2"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias           = "dev"
  subscription_id = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
}

provider "azurerm" {
  features {}
  alias           = "uat"
  subscription_id = data.azurerm_subscriptions.uat.subscriptions[0].subscription_id
}

provider "azurerm" {
  features {}
  alias           = "prod"
  subscription_id = data.azurerm_subscriptions.prod.subscriptions[0].subscription_id
}

module "__v4__" {
  # https://github.com/pagopa/terraform-azurerm-v4/releases/tag/v1.5.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4.git?ref=876158038b03d7a82ea437c56591154ab504d725"
}

module "__devops_v0__" {
  # https://github.com/pagopa/azuredevops-tf-modules/releases/tag/v9.2.1
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git?ref=7e23d73d22e7b37352c25a32cc40f6f42b6569ea"
}
