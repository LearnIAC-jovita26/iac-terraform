terraform {
  required_version = ">= 1.16.0"
}

# Leser state, skriver aldri. Samme backend som modul 6, produsentens key.
data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-demo-backend-jovita26"
    storage_account_name = "stdemojovita26"
    container_name       = "tfstate"
    key                  = "modul8/dev/network.tfstate"
    use_azuread_auth     = true
  }
}

output "hentet_subnet" {
  value = data.terraform_remote_state.network.outputs.subnet_id
}
