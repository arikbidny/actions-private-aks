variable "AZURE_SUBSCRIPTION_ID" {
  description = "value of the subscription id"
}

variable "AZURE_TENANT_ID" {
  description = "value of the tenant id"
}

variable "AZURE_CLIENT_ID" {
  description = "value of the client id"
}


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
    subscription_id      = var.AZURE_SUBSCRIPTION_ID
    tenant_id            = var.AZURE_TENANT_ID
    client_id            = var.AZURE_CLIENT_ID
  }

  # backend "azurerm" {
  #   resource_group_name  = "bacloud-terraform-state-rg"
  #   storage_account_name = "bacloudterraformstate"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  #   use_oidc             = true
  #   subscription_id      = "9a787734-ee5c-422e-ba06-938e14b79c31"
  #   tenant_id            = "34a7b585-cb55-4d8e-9f2b-37560c2fa9b9"
  #   client_id            = "14b46d58-2c62-4e95-bf21-2f8d8ae13788"
  # }
}
