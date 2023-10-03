resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name}PublicIp"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# resource "azurerm_monitor_diagnostic_setting" "settings" {
#   count                      = 2
#   name                       = "DiagnosticsSettingsBastionHost-${count.index}"
#   target_resource_id         = azurerm_bastion_host.bastion_host.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id

#   enabled_log {
#     category = "BastionAuditLogs"

#     retention_policy {
#       enabled = true
#     }
#   }

#   metric {
#     category = "AllMetrics"

#     retention_policy {
#       enabled = true
#     }
#   }
# }

# resource "azurerm_monitor_diagnostic_setting" "pip_settings" {
#   count                      = 2
#   name                       = "DiagnosticsSettingsMonitor-${count.index}"
#   target_resource_id         = azurerm_public_ip.public_ip.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id

#   enabled_log {
#     category = "DDoSProtectionNotifications"

#     retention_policy {
#       enabled = true
#     }
#   }

#   enabled_log {
#     category = "DDoSMitigationFlowLogs"

#     retention_policy {
#       enabled = true
#     }
#   }

#   enabled_log {
#     category = "DDoSMitigationReports"

#     retention_policy {
#       enabled = true
#     }
#   }

#   metric {
#     category = "AllMetrics"

#     retention_policy {
#       enabled = true
#     }
#   }
# }
