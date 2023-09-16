# terraform {
#   backend "azurerm" {
#   }
# }

locals {
  storage_account_prefix = "boot"
  route_table_name       = "DefaultRouteTable"
  route_name             = "RouteToAzureFirewall"
}

data "azurerm_client_config" "current" {
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}


######### LOG ANALYTICS WORKSPACE #########

module "log_analytics_workspace" {
  source              = "./modules/log_analytics"
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  solution_plan_map   = var.solution_plan_map
}


######### HUB Resources ###################
resource "azurerm_resource_group" "hub_rg" {
  name     = var.hub_resource_group_name
  location = var.location
  tags     = var.tags
}

module "hub_network" {
  source                       = "./modules/virtual_network"
  resource_group_name          = azurerm_resource_group.hub_rg.name
  location                     = var.location
  vnet_name                    = var.hub_vnet_name
  address_space                = var.hub_address_space
  tags                         = var.tags
  log_analytics_workspace_id   = module.log_analytics_workspace.id
  log_analytics_retention_days = var.log_analytics_retention_days

  subnets = [
    {
      name : "AzureFirewallSubnet"
      address_prefixes : var.hub_firewall_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : "AzureBastionSubnet"
      address_prefixes : var.hub_bastion_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    }
  ]
}

######### AKS Network #############
resource "azurerm_resource_group" "aks_rg" {
  name     = var.aks_resource_group_name
  location = var.location
  tags     = var.tags
}


module "aks_network" {
  source                       = "./modules/virtual_network"
  resource_group_name          = azurerm_resource_group.aks_rg.name
  location                     = var.location
  vnet_name                    = var.aks_vnet_name
  address_space                = var.aks_vnet_address_space
  log_analytics_workspace_id   = module.log_analytics_workspace.id
  log_analytics_retention_days = var.log_analytics_retention_days

  subnets = [
    {
      name : var.default_node_pool_subnet_name
      address_prefixes : var.default_node_pool_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : var.additional_node_pool_subnet_name
      address_prefixes : var.additional_node_pool_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : var.pod_subnet_name
      address_prefixes : var.pod_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : var.vm_subnet_name
      address_prefixes : var.vm_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    }
  ]
}
