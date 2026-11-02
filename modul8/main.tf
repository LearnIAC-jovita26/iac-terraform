terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  backend "azurerm" {} # tom – fylles ved init
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location

  tags = {
    student    = var.student_id
    course     = "iac"
    managed_by = "pipeline"
  }
}

module "network" {
  source              = "git::https://github.com/LearnIAC-jovita26/iac-terraform.git//modules/network?ref=network-v1.1.0"
  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

