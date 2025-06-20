data "juju_offer" "ingress" {
  url = var.ingress_offer_url
}

data "juju_offer" "database" {
  url = var.postgresql_offer_url
}

data "juju_offer" "ca_certificate" {
  url = var.send_ca_certificate_offer_url
}

// openfga

resource "juju_offer" "openfga_offer" {
  model            = var.model
  name             = "openfga"
  application_name = juju_application.openfga.name
  endpoints        = ["openfga"]
}

resource "juju_integration" "openfga_db" {
  model = var.model

  application {
    offer_url = data.juju_offer.database.url
  }

  application {
    name     = juju_application.openfga.name
    endpoint = "database"
  }
}

// idp

resource "juju_integration" "kratos_external_idp" {
  model = var.model

  application {
    name     = module.kratos_external_idp_integrator.name
    endpoint = "kratos-external-idp"
  }

  application {
    name     = var.kratos_name
    endpoint = "kratos-external-idp"
  }
}

// internal networking

resource "juju_integration" "kratos_admin_ui_info" {
  model = var.model

  application {
    name     = var.kratos_name
    endpoint = "kratos-info"
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "kratos-info"
  }
}

resource "juju_integration" "hydra_admin_ui_info" {
  model = var.model

  application {
    name     = var.hydra_name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "hydra_admin_ui_oauth" {
  model = var.model

  application {
    name     = var.hydra_name
    endpoint = "oauth"
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "oauth"
  }
}

resource "juju_integration" "admin_ui_public_ingress" {
  model = var.model

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "openfga_admin_ui" {
  model = var.model

  application {
    name     = juju_application.openfga.name
    endpoint = "openfga"
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "openfga"
  }
}

resource "juju_integration" "oauth_ca_admin_ui" {
  model = var.model

  application {
    offer_url = data.juju_offer.ca_certificate.url
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "receive-ca-cert"
  }
}
