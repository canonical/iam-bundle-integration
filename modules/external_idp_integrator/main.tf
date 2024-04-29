terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 0.11.0"
    }
  }

  required_version = ">= 1.5.0"
}

resource "juju_application" "external_idp_integrator" {
  model = var.model
  name  = var.name
  trust = var.trust
  units = var.units

  charm {
    name    = var.charm.name
    channel = var.charm.channel
    series  = var.charm.series
  }

  config = {
    for k, v in var.config : k => v if v != null
  }
}
