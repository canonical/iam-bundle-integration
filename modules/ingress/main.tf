terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 0.8.0"
    }
  }

  required_version = ">= 1.5.0"
}

resource "juju_application" "ingress" {
  model = var.model
  name  = var.name
  trust = var.trust
  units = var.units

  charm {
    name    = var.charm.name
    channel = var.charm.channel
    series  = var.charm.series
  }
}
