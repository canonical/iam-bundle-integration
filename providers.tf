terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 1.1.0"
    }
  }

  required_version = ">= 1.6.6"
}
