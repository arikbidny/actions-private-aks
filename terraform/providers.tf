# variable "AZURE_SUBSCRIPTION_ID" {
#   description = "value of the subscription id"
# }

# variable "AZURE_TENANT_ID" {
#   description = "value of the tenant id"
# }

# variable "AZURE_CLIENT_ID" {
#   description = "value of the client id"
# }


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

  # backend "azurerm" {
  #   resource_group_name  = "bacloud-terraform-state-rg"
  #   storage_account_name = "bacloudterraformstate"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  #   use_oidc             = true
  #   subscription_id      = var.AZURE_SUBSCRIPTION_ID
  #   tenant_id            = var.AZURE_TENANT_ID
  #   client_id            = var.AZURE_CLIENT_ID
  # }

  backend "azurerm" {
    resource_group_name  = "bacloud-terraform-state-rg"
    storage_account_name = "bacloudterraformstate01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
    subscription_id      = "1912699e-f189-43ca-8356-21d71c13538d"
    tenant_id            = "62a174ac-4d1b-44ce-a7f1-af58ac99e17b"
    client_id            = "19ebefba-02c4-4de4-bd5c-0e8f4adf9e1b"
  }
}
