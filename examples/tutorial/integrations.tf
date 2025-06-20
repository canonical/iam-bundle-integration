resource "juju_offer" "oauth_offer" {
  name             = "oauth-offer"
  model            = juju_model.iam.name
  application_name = juju_application.hydra.name
  endpoints        = ["oauth"]
}

resource "juju_offer" "kratos_info_offer" {
  name             = "kratos-info-offer"
  model            = juju_model.iam.name
  application_name = juju_application.kratos.name
  endpoints        = ["kratos-info"]
}

// public ingresses

resource "juju_integration" "login_ui_public_ingress" {
  model = juju_model.iam.name

  application {
    offer_url = module.core.ingress_offer_url
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "hydra_public_ingress" {
  model = juju_model.iam.name

  application {
    offer_url = module.core.ingress_offer_url
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "public-ingress"
  }
}

resource "juju_integration" "kratos_public_ingress" {
  model = juju_model.iam.name

  application {
    offer_url = module.core.ingress_offer_url
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "public-ingress"
  }
}

// databases

resource "juju_integration" "hydra_database" {
  model = juju_model.iam.name

  application {
    offer_url = module.core.postgresql_offer_url
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "pg-database"
  }
}

resource "juju_integration" "kratos_database" {
  model = juju_model.iam.name

  application {
    offer_url = module.core.postgresql_offer_url
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "pg-database"
  }
}

// internal networking

resource "juju_integration" "kratos_hydra_info" {
  model = juju_model.iam.name

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
  model = juju_model.iam.name

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
  model = juju_model.iam.name

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
  model = juju_model.iam.name

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
  model = juju_model.iam.name

  application {
    name     = juju_application.hydra.name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ui-endpoint-info"
  }
}
