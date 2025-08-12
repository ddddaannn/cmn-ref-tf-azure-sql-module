variable "server_name" {
  type        = string
  description = "SQL Server name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Target RG"
}

variable "administrator_login" {
  type        = string
  description = "Admin username"
}

variable "administrator_password" {
  type        = string
  sensitive   = true
}

variable "public_network_access" {
  type        = bool
  default     = false
}

variable "min_tls_version" {
  type        = string
  default     = "1.2"
}

variable "aad_admin_object_id" {
  type        = string
  default     = null
}

variable "aad_admin_login_name" {
  type        = string
  default     = null
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for AAD admin"
}

variable "db_name" {
  type        = string
  default     = null
}

variable "sku_name" {
  type        = string
  default     = "GP_S_Gen5_2"
}

variable "threat_detection_email" {
  type        = string
  default     = null
}

variable "diag_log_analytics_id" {
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
}
