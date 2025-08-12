provider "azurerm" {
  features {}
}

module "sql" {
  source                 = "../../modules/sql"
  server_name            = "sqldevsea001"
  location               = "southeastasia"
  resource_group_name    = "rg-sql-dev-sea"
  tenant_id              = "YOUR_TENANT_ID_HERE"
  administrator_login    = "sqladminuser"
  administrator_password = "P@ssw0rd-rotate-in-kv"
  public_network_access  = false
  db_name                = "appdb"
  sku_name               = "GP_S_Gen5_2"
  tags = {
    env   = "dev"
    owner = "test"
  }
}

output "fqdn" {
  value = module.sql.sql_server_fqdn
}
