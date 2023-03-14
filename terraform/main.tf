terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.47.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "=3.4.3"
    }
  }
}

provider "azurerm" {
  features {}
}

# data "azurerm_resource_group" "rg" {
#   name = var.az_rg_name
# }

resource "azurerm_key_vault" "bad_example" {
  name                        = "test-asd-asd-ouhhearh12"
  location                    = "West Europe"
  resource_group_name         = "test-asd-rg"
  enabled_for_disk_encryption = true
  tenant_id                   = "123456ab-1a2b-3c45-67de-1234ab567cd8"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_secret" "bad_example" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.bad_example.id 
}
