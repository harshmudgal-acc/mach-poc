provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mach-composer" {
  name     = "machpoc-functions-python-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "mach-composer" {
  name                      = "machpocstorageacct001"
  resource_group_name       = azurerm_resource_group.mach-composer.name
  location                  = azurerm_resource_group.mach-composer.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  primary_access_key        = "X2YpP+RWI0Q+V/AwDL6AlNFXk2mppfL3gM8s3V36fo/0YuZPcmHAdJnBQ9qNErC4qEgJYhtzSnDC+AStSystzQ=="
}

resource "azurerm_service_plan" "mach-composer" {
  name                = "ASP-machcomposer-fa-0007"
  resource_group_name = azurerm_resource_group.mach-composer.name
  location            = azurerm_resource_group.mach-composer.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "mach-composer" {
  name                = "machcomposer-fa"
  resource_group_name = azurerm_resource_group.mach-composer.name
  location            = azurerm_resource_group.mach-composer.location

  storage_account_name       = azurerm_storage_account.mach-composer.name
  storage_account_access_key = azurerm_storage_account.mach-composer.primary_access_key
  service_plan_id            = azurerm_service_plan.mach-composer.id

  site_config {}
}