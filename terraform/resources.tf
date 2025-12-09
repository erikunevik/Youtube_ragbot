resource "azurerm_resource_group" "resource_group" { # First name is naming convention, second whats its called in terraform
  name     = "${var.prefix_app_name}-${random_string.suffix.result}-RG" # Name in azure
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_service_plan" "asp" {
  name                = "${var.prefix_app_name}-${random_string.suffix.result}-asp"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "S1" # Price level
  os_type             = "Linux"
  tags                = local.common_tags
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.prefix_app_name}-${random_string.suffix.result}-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true

    application_stack {
      python_version = "3.12"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "OPENAI_API_KEY"           = var.openai_api_key
    "SUBSCRIPTION_ID"          = var.subscription_id
  }
}