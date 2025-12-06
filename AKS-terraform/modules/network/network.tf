resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "network_subnet" {
  name                 = "${var.virtual_network_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}  

resource "azurerm_network_security_group" "security_group" {
  name                = var.security_group_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range = "*"
    destination_port_range     = 22
    source_address_prefix      = var.allowed_ssh_source_address_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range = "*"
    destination_port_range     = 443
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Attach NSG to subnet
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.network_subnet.id
  network_security_group_id = azurerm_network_security_group.security_group.id
}

output "security_group_id" {
  value =  azurerm_network_security_group.security_group.id
}
output "subnet_id" {
  value = azurerm_subnet.network_subnet.id
}