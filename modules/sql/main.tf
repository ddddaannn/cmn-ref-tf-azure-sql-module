resource "azurerm_mssql_server" "this" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password
  public_network_access_enabled = var.public_network_access

  minimum_tls_version = var.min_tls_version

  tags = var.tags
}

# Optional AAD admin
resource "azurerm_mssql_active_directory_administrator" "aad_admin" {
  count               = var.aad_admin_object_id != null ? 1 : 0
  server_id           = azurerm_mssql_server.this.id
  login               = var.aad_admin_login_name
  object_id           = var.aad_admin_object_id
  tenant_id           = var.tenant_id
}

# Optional DB
resource "azurerm_mssql_database" "this" {
  count                = var.db_name != null ? 1 : 0
  name                 = var.db_name
  server_id            = azurerm_mssql_server.this.id
  sku_name             = var.sku_name
  zone_redundant       = false
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = -1
  max_size_gb          = 2

  tags = var.tags
}

# Optional threat detection
resource "azurerm_mssql_server_security_alert_policy" "this" {
  count              = var.threat_detection_email != null ? 1 : 0
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.this.name
  state               = "Enabled"
  email_account_admins = "Enabled"
  email_addresses      = [var.threat_detection_email]
}

# Optional diagnostics
resource "azurerm_monitor_diagnostic_setting" "sql_diag" {
  count                  = var.diag_log_analytics_id != null ? 1 : 0
  name                   = "${var.server_name}-diag"
  target_resource_id     = azurerm_mssql_server.this.id
  log_analytics_workspace_id = var.diag_log_analytics_id

  enabled_log {
    category = "SQLSecurityAuditEvents"
  }
  enabled_log {
    category = "AutomaticTuning"
  }
  metric {
    category = "AllMetrics"
  }
}
