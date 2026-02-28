terraform {
  required_providers {
    azurerm = {

        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }    
  }

  backend "azurerm" {
        resource_group_name  = "rg-terraform-state"
        storage_account_name = "tfunianchieta001" # Nome único
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "aula_aovivo_rg" {
  name     = "rg-aulaaovivo"
  location = "Canada Central"
}


resource "azurerm_service_plan" "aula_aovivo_serviceplan" {
  name                = "aula_aovivo_service"
  resource_group_name = azurerm_resource_group.aula_aovivo_rg.name
  os_type             = "Linux"
  sku_name            = "F1"
  location = "Canada Central"
}

resource "azurerm_linux_web_app" "aula_aovivo_webapp" {
  name = "aula-aovivo-webapp"
  resource_group_name = azurerm_resource_group.aula_aovivo_rg.name
  location = "Canada Central"
  service_plan_id = azurerm_service_plan.aula_aovivo_serviceplan.id

  site_config {
    always_on = false
    application_stack {
      node_version = "18-lts"
    }
  }
}