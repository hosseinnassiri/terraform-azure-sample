variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  type        = string
  default     = "canadacentral"
  description = "Location of the resource group."
}

variable "azure_subscription_id" {
  type      = string
  sensitive = true
}

variable "azure_subscription_tenant_id" {
  type      = string
  sensitive = true
}

variable "service_principal_appid" {
  type      = string
  sensitive = true
}

variable "service_principal_password" {
  type      = string
  sensitive = true
}
