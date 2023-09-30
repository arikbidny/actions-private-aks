provider "azurerm" {
  use_oidc = true
  features {

  }
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.50"
    }
  }

  backend "azurerm" {
    resource_group_name  = "bacloud-terraform-state-rg"
    storage_account_name = "bacloudterraformstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
    subscription_id      = "9a787734-ee5c-422e-ba06-938e14b79c31"
    tenant_id            = "34a7b585-cb55-4d8e-9f2b-37560c2fa9b9"
  }
}
