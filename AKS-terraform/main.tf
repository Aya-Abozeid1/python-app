terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "fd5b0499-27bb-4141-a8b6-e7757b04968b"
  features {}
}
# Call network module
module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
  virtual_network_name = var.virtual_network_name
  allowed_ssh_source_address_prefix = var.allowed_ssh_source_address_prefix
  security_group_name = var.security_group_name
  
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
  acr_name = var.acr_name
}

# Call AKS module
module "aks-cluster" {
  source              = "./modules/aks-cluster"
  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
  cluster_name = var.cluster_name
  dns_prefix   = var.dns_prefix
  vnet_subnet_id = module.network.subnet_id
  depends_on = [ module.network ]
}

