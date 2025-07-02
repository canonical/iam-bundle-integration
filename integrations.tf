data "juju_offer" "database" {
  url = var.postgresql_offer_url
}

data "juju_offer" "ingress" {
  url = var.ingress_offer_url
}

data "juju_offer" "openfga" {
  url   = var.openfga_offer_url
  count = var.enable_admin_ui ? 1 : 0
}

data "juju_offer" "ca_certificate" {
  url = var.send_ca_certificate_offer_url
}

// public ingresses
resource "juju_integration" "login_ui_public_ingress" {
  model = data.juju_model.this.name

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = module.login_ui.app_name
    endpoint = "ingress"
  }
}

resource "juju_integration" "hydra_public_ingress" {
  model = data.juju_model.this.name

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = module.hydra.app_name
    endpoint = "public-ingress"
  }
}

resource "juju_integration" "kratos_public_ingress" {
  model = data.juju_model.this.name

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = module.kratos.app_name
    endpoint = "public-ingress"
  }
}

// databases

resource "juju_integration" "hydra_database" {
  model = data.juju_model.this.name

  application {
    offer_url = data.juju_offer.database.url
  }

  application {
    name     = module.hydra.app_name
    endpoint = "pg-database"
  }
}

resource "juju_integration" "kratos_database" {
  model = data.juju_model.this.name

  application {
    offer_url = data.juju_offer.database.url
  }

  application {
    name     = module.kratos.app_name
    endpoint = "pg-database"
  }
}

// idp

resource "juju_integration" "kratos_external_idp" {
  model = data.juju_model.this.name
  count = var.enable_kratos_external_idp_integrator ? 1 : 0

  application {
    name     = module.kratos_external_idp_integrator[0].app_name
    endpoint = "kratos-external-idp"
  }

  application {
    name     = module.kratos.app_name
    endpoint = "kratos-external-idp"
  }
}

// internal networking

resource "juju_integration" "kratos_hydra_info" {
  model = data.juju_model.this.name

  application {
    name     = module.hydra.app_name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = module.kratos.app_name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "login_ui_hydra_info" {
  model = data.juju_model.this.name

  application {
    name     = module.hydra.app_name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = module.login_ui.app_name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "kratos_login_ui_info" {
  model = data.juju_model.this.name

  application {
    name     = module.login_ui.app_name
    endpoint = "kratos-info"
  }

  application {
    name     = module.kratos.app_name
    endpoint = "kratos-info"
  }
}

resource "juju_integration" "kratos_login_ui_ui_info" {
  model = data.juju_model.this.name

  application {
    name     = module.kratos.app_name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = module.login_ui.app_name
    endpoint = "ui-endpoint-info"
  }
}

resource "juju_integration" "hydra_login_ui_ui_info" {
  model = data.juju_model.this.name

  application {
    name     = module.hydra.app_name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = module.login_ui.app_name
    endpoint = "ui-endpoint-info"
  }
}

resource "juju_integration" "kratos_admin_ui_info" {
  model = data.juju_model.this.name
  count = var.enable_admin_ui ? 1 : 0

  application {
    name     = module.kratos.app_name
    endpoint = "kratos-info"
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "kratos-info"
  }
}

resource "juju_integration" "hydra_admin_ui_info" {
  model = data.juju_model.this.name
  count = var.enable_admin_ui ? 1 : 0

  application {
    name     = module.hydra.app_name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "hydra_admin_ui_oauth" {
  model = data.juju_model.this.name
  count = var.enable_admin_ui ? 1 : 0

  application {
    name     = module.hydra.app_name
    endpoint = "oauth"
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "oauth"
  }
}

resource "juju_integration" "admin_ui_public_ingress" {
  model = data.juju_model.this.name
  count = var.enable_admin_ui ? 1 : 0

  application {
    offer_url = data.juju_offer.ingress.url
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "ingress"
  }
}

resource "juju_integration" "openfga_admin_ui" {
  model = data.juju_model.this.name
  count = var.enable_admin_ui ? 1 : 0

  application {
    offer_url = data.juju_offer.openfga[0].url
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "openfga"
  }
}

resource "juju_integration" "oauth_ca_admin_ui" {
  model = data.juju_model.this.name
  count = var.enable_admin_ui ? 1 : 0

  application {
    offer_url = data.juju_offer.ca_certificate.url
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "receive-ca-cert"
  }
}
