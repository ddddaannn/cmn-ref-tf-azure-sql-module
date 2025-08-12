output "sql_server_id" {
  value = azurerm_mssql_server.this.id
}

output "sql_server_name" {
  value = azurerm_mssql_server.this.name
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_db_id" {
  value       = try(azurerm_mssql_database.this[0].id, null)
  description = "ID of created DB, if any"
}
