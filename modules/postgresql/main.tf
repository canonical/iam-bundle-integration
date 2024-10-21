terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 0.15.0"
    }
  }

  required_version = ">= 1.5.0"
}

resource "juju_application" "postgresql" {
  model = var.model
  name  = var.name
  trust = var.trust
  units = var.units

  charm {
    name    = var.charm.name
    channel = var.charm.channel
    base    = var.charm.base
  }

  config = {
    plugin_pg_trgm_enable   = "true"
    plugin_uuid_ossp_enable = "true"
    plugin_btree_gin_enable = "true"
  }
}
