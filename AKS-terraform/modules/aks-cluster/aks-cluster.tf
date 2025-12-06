resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.cluster_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix         = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2ls_v2"
    vnet_subnet_id = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    dns_service_ip    = "10.0.0.10"
    service_cidr      = "10.0.0.0/24"
    load_balancer_sku = "standard"
  }

}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw

  sensitive = true
}