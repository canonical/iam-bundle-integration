terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 0.14.0"
    }
  }

  required_version = ">= 1.5.0"
}
