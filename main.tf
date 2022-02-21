terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_subscription_tenant_id
  client_id       = var.service_principal_appid
  client_secret   = var.service_principal_password
}

resource "random_pet" "rg-name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg-name.id
  location = var.resource_group_location

  tags = {
    Environment = "terraform.dev"
    Team        = "bashash"
  }
}

resource "azurerm_storage_account" "stg" {
  name                      = "${var.storage_account_prefix}storageacct"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  access_tier               = "Hot"
  allow_blob_public_access  = false
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = var.storage_account_container
  storage_account_name  = azurerm_storage_account.stg.name
  container_access_type = "private"
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "storage_account_id" {
  value = azurerm_storage_account.stg.id
}
