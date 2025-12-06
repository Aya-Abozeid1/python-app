variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  default = "test-environment-rg"
}

variable "resource_group_location" {
  description = "The location of the resource group in which to create the resources."
  default = "East US"
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "value"
}

variable "dns_prefix" {
  description = "The DNS prefix to use with the AKS cluster."
  type        = string
  default     = "value"
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet in the virtual network."
  type        = string
}