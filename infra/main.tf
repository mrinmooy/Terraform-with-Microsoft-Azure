terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "rg-terraform-new"
  location = "eastus"
}

# Create a storage account
resource "azurerm_storage_account" "storage_account" {
  name                                = "terraformazuremrinmoy"
  resource_group_name        = azurerm_resource_group.resource_group.name
  location                             = azurerm_resource_group.resource_group.location
  account_tier                      = "Standard"
  account_replication_type     = "LRS"
  account_kind                      = "StorageV2"

  static_website {
    index_document = "index.html"
  }
}

# Add an index html file
resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = file("./index.html")
}