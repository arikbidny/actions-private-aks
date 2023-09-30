provider "azurerm" {
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
  }
}
