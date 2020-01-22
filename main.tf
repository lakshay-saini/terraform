provider "azurerm" {
  version = "=1.38.0"

  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "00000000-0000-0000-0000-000000000000"
  tenant_id       = "00000000-0000-0000-0000-000000000000"
}

resource "azurerm_resource_group" "deploy_group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "random_id" "workspace" {
  keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = "${azurerm_resource_group.deploy_group.name}"
  }
  
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "deploy_log_analytics_workspace" {
  name                = "${var.prefix}-log-analytics-workspace"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "${var.sku}"
  retention_in_days   = "${var.retention_in_days}"
}

resource "azurerm_log_analytics_solution" "deploy_log_analytics_solution" {
  solution_name         = "ContainerInsights"
  location              = "${azurerm_resource_group.deploy_group.location}"
  resource_group_name   = "${azurerm_resource_group.deploy_group.name}"
  workspace_resource_id = "${azurerm_log_analytics_workspace.deploy_log_analytics_workspace.id}"
  workspace_name        = "${azurerm_log_analytics_workspace.deploy_log_analytics_workspace.name}"

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
