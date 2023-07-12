terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 0.8.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "juju" {}
