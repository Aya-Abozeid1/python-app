variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  default = "test-environment-rg"
}

variable "resource_group_location" {
  description = "The location of the resource group in which to create the resources."
  default = "East US"
}

variable "security_group_name" {
  description = "The name of the network security group."
  type = string
  default = "value"
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type       = string
  default    = "value"
}

variable "allowed_ssh_source_address_prefix" {
  description = "The source address prefix allowed to access SSH."
  type        = string
  default     = "value"
}
