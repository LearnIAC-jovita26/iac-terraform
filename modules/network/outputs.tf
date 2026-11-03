output "subnet_id" {
  description = "ID til subnettet, til bruk for f.eks. en NIC"
  value       = azurerm_subnet.app.id
}

