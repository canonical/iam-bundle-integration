terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 1.4.0"
    }
  }

  required_version = ">= 1.6.6"
}
