terraform {
  required_version = ">= 1.6.6"
  required_providers {
    juju = {
      source  = "juju/juju"
      version = ">= 0.15.0"
    }
  }
}

provider "juju" {
  controller_addresses = var.jimm_url

  client_id     = var.client_id
  client_secret = var.client_secret
}
