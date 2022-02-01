global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  mysql_region1 = {
    name   = "mysql-region1"
    region = "region1"
  }
  security_region1 = {
    name = "security-region1"
  }
}

mysql_flexible_servers = {
  primary_region1 = {
    name       = "primary-region1"
    region     = "region1"
    version    = "12"
    sku_name   = "MO_Standard_E4s_v3"
    storage_mb = 131072

    resource_group = {
      key = "mysql_region1"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }

    # Auto-generated administrator credentials stored in azure keyvault when not set (recommended).
    # administrator_username  = "psqladmin"
    # administrator_password  = "ComplxP@ssw0rd!"
    keyvault = {
      key = "mysql_region1"              # (Required) when auto-generated administrator credentials needed.
      # lz_key      = ""                      # Set the lz_key if the keyvault is remote.
    }

    # [Optional] Firewall Rules
    mysql_firewall_rules = {
      mysql-firewall-rule1 = {
        name             = "mysql-firewall-rule1"
        start_ip_address = "10.0.1.10"
        end_ip_address   = "10.0.1.11"
      }
      mysql-firewall-rule2 = {
        name             = "mysql-firewall-rule2"
        start_ip_address = "10.0.2.10"
        end_ip_address   = "10.0.2.11"
      }
    }

    # [Optional] Server Configurations
    mysql_configurations = {
      backslash_quote = {
        name  = "backslash_quote"
        value = "on"
      }
      bgwriter_delay = {
        name  = "bgwriter_delay"
        value = "25"
      }
    }


    mysql_databases = {
      mysql_database = {
        name = "sampledb"
      }
    }

    tags = {
      segment = "sales"
    }

  }

}

# Store the postgresql_flexible_server administrator credentials into keyvault if the attribute keyvault{} block is defined.
keyvaults = {
  mysql_region1 = {
    name                = "mysql-region1"
    resource_group_key  = "security_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}
