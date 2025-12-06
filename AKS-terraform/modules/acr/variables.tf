variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  default = "test-environment-rg"
}

variable "resource_group_location" {
  description = "The location of the resource group in which to create the resources."
  default = "East US"
}

variable "acr_name" {
  description = "name of ACR"
  type        = string
  default     = "value"
}