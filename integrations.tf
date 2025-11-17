data "juju_offer" "database" {
  url = var.postgresql_offer_url
}

data "juju_offer" "traefik_route" {
  url = var.traefik_route_offer_url
}

data "juju_offer" "ca_certificate" {
  url = var.send_ca_certificate_offer_url
}

// public routes
resource "juju_integration" "login_ui_public_route" {

  application {
    offer_url = data.juju_offer.traefik_route.url
  }

  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.requires.public-route
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "hydra_public_route" {

  application {
    offer_url = data.juju_offer.traefik_route.url
  }

  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.requires.public-route
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "kratos_public_route" {

  application {
    offer_url = data.juju_offer.traefik_route.url
  }

  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.public-route
  }
  model_uuid = data.juju_model.this.uuid
}

// databases

resource "juju_integration" "hydra_database" {

  application {
    offer_url = data.juju_offer.database.url
  }

  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.requires.pg-database
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "kratos_database" {

  application {
    offer_url = data.juju_offer.database.url
  }

  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.pg-database
  }
  model_uuid = data.juju_model.this.uuid
}

// idp

resource "juju_integration" "kratos_external_idp" {
  count = var.enable_kratos_external_idp_integrator ? 1 : 0

  application {
    name     = module.kratos_external_idp_integrator[0].app_name
    endpoint = module.kratos_external_idp_integrator[0].provides.kratos-external-idp
  }

  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.kratos-external-idp
  }
  model_uuid = data.juju_model.this.uuid
}

// internal networking

resource "juju_integration" "kratos_hydra_info" {

  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.provides.hydra-endpoint-info
  }

  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.hydra-endpoint-info
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "login_ui_hydra_info" {

  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.provides.hydra-endpoint-info
  }

  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.requires.hydra-endpoint-info
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "kratos_login_ui_info" {
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.provides.kratos-info
  }

  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.requires.kratos-info
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "kratos_login_ui_ui_info" {
  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.provides.ui-endpoint-info
  }

  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.ui-endpoint-info
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "hydra_login_ui_ui_info" {
  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.provides.ui-endpoint-info
  }

  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.requires.ui-endpoint-info
  }
  model_uuid = data.juju_model.this.uuid
}
