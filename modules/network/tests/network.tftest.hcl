mock_provider "azurerm" {}

variables {
  name_prefix         = "test"
  location            = "norwayeast"
  resource_group_name = "rg-test"
}

run "subnettene_har_riktig_cidr" {
  command = plan

  assert {
    condition     = contains(azurerm_subnet.this.address_prefixes, "10.0.1.0/24")
    error_message = "Subnettet this skal ha 10.0.1.0/24."
  }

  assert {
    condition     = contains(azurerm_subnet.data.address_prefixes, "10.0.2.0/24")
    error_message = "Subnettet data skal ha 10.0.2.0/24."
  }
}

run "navnene_bruker_prefikset" {
  command = plan

  assert {
    condition     = azurerm_virtual_network.this.name == "test-vnet"
    error_message = "VNet skal hete <prefiks>-vnet."
  }

  assert {
    condition     = azurerm_subnet.this.name == "test-snet"
    error_message = "Subnettet this skal hete <prefiks>-snet."
  }

  assert {
    condition     = azurerm_subnet.data.name == "test-data-snet"
    error_message = "Subnettet data skal hete <prefiks>-data-snet."
  }
}

run "ugyldig_prefiks_avvises" {
  command = plan

  variables {
    name_prefix = "UGYLDIG_NAVN!"
  }

  expect_failures = [var.name_prefix]
}


run "ssh_er_ikke_aapen_mot_internett" {
  command = plan

  assert {
    condition = alltrue([
      for r in azurerm_network_security_group.this.security_rule :
      !(r.destination_port_range == "22" && r.source_address_prefix == "*")
    ])
    error_message = "SSH (port 22) må ikke være åpen mot hele internett."
  }
}
