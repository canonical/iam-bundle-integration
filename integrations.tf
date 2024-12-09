data "juju_offer" "database" {
  url = var.postgresql_offer_url
}

data "juju_offer" "ingress" {
  url = var.ingress_offer_url
}

data "juju_offer" "openfga" {
  url = var.openfga_offer_url
}

// public ingresses
resource "juju_integration" "login_ui_public_ingress" {
  model = var.model

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "hydra_public_ingress" {
  model = var.model

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "public-ingress"
  }
}

resource "juju_integration" "kratos_public_ingress" {
  model = var.model

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "public-ingress"
  }
}

// databases

resource "juju_integration" "hydra_database" {
  model = var.model

  application {
    offer_url = data.juju_offer.database.url
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "pg-database"
  }
}

resource "juju_integration" "kratos_database" {
  model = var.model

  application {
    offer_url = data.juju_offer.database.url
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "pg-database"
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
    name     = juju_application.kratos.name
    endpoint = "kratos-external-idp"
  }
}

// internal networking

resource "juju_integration" "kratos_hydra_info" {
  model = var.model

  application {
    name     = juju_application.hydra.name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "login_ui_hydra_info" {
  model = var.model

  application {
    name     = juju_application.hydra.name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "kratos_login_ui_info" {
  model = var.model

  application {
    name     = juju_application.login_ui.name
    endpoint = "kratos-info"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "kratos-info"
  }
}

resource "juju_integration" "kratos_login_ui_ui_info" {
  model = var.model

  application {
    name     = juju_application.kratos.name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ui-endpoint-info"
  }
}

resource "juju_integration" "hydra_login_ui_ui_info" {
  model = var.model

  application {
    name     = juju_application.hydra.name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ui-endpoint-info"
  }
}

resource "juju_integration" "kratos_admin_ui_info" {
  model = var.model

  application {
    name     = juju_application.kratos.name
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
    name     = juju_application.hydra.name
    endpoint = "hydra-info"
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "hydra-info"
  }
}

resource "juju_integration" "hydra_admin_ui_oauth" {
  model = var.model

  application {
    name     = juju_application.hydra.name
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
    offer_url = data.juju_offer.openfga.url
  }

  application {
    name     = juju_application.admin_ui.name
    endpoint = "openfga"
  }
}
