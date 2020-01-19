provider "azurerm" {
  version = "=1.38.0"

  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "00000000-0000-0000-0000-000000000000"
  tenant_id       = "00000000-0000-0000-0000-000000000000"
}
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.prefix}-log-analytics-workspace"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "${var.sku}"
  retention_in_days   = "${var.retention_in_days}"
}
