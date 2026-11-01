output "resource_group_name" {
  description = "Navnet på ressursgruppen som ble opprettet"
  value       = azurerm_resource_group.main.name
}

output "name_prefix" {
  description = "Navneprefikset alle ressursene dine deler"
  value       = local.name_prefix
}

output "subnet_id" {
  description = "ID til subnettet, hentet fra nettverksmodulen"
  value       = module.network.subnet_id
}
