resource "juju_offer" "ingress" {
  name             = "ingress"
  application_name = module.traefik.app_name
  endpoints        = ["ingress"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "traefik_route" {
  name             = "traefik-route"
  application_name = module.traefik.app_name
  endpoints        = ["traefik-route"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "postgresql" {
  name             = "postgresql"
  application_name = module.postgresql.application_name
  endpoints        = ["database"]
  model_uuid       = juju_model.core.uuid
}


resource "juju_offer" "send_ca_certificate" {
  name             = "send-ca-cert"
  application_name = module.certificates.app_name
  endpoints        = ["send-ca-cert"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "openfga" {
  name             = "openfga"
  application_name = module.openfga.app_name
  endpoints        = ["openfga"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_integration" "traefik_certs" {
  application {
    name     = module.traefik.app_name
    endpoint = "certificates"
  }

  application {
    name     = module.certificates.app_name
    endpoint = "certificates"
  }
  model_uuid = juju_model.core.uuid
}

// openfga

resource "juju_integration" "openfga_db" {

  application {
    name     = module.postgresql.application_name
    endpoint = "database"
  }

  application {
    name     = module.openfga.app_name
    endpoint = "database"
  }
  model_uuid = juju_model.core.uuid
}

resource "juju_integration" "kratos_admin_ui_info" {
  application {
    name     = "kratos"
    endpoint = "kratos-info"
  }

  application {
    name     = "admin-ui"
    endpoint = "kratos-info"
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "hydra_admin_ui_info" {
  application {
    name     = "hydra"
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = "admin-ui"
    endpoint = "hydra-endpoint-info"
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "hydra_admin_ui_oauth" {
  application {
    name     = "hydra"
    endpoint = "oauth"
  }

  application {
    name     = "admin-ui"
    endpoint = "oauth"
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "admin_ui_public_ingress" {
  application {
    offer_url = juju_offer.ingress.url
  }

  application {
    name     = "admin-ui"
    endpoint = "ingress"
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "openfga_admin_ui" {
  application {
    offer_url = juju_offer.openfga.url
  }

  application {
    name     = "admin-ui"
    endpoint = "openfga"
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "oauth_ca_admin_ui" {
  application {
    offer_url = juju_offer.send_ca_certificate.url
  }

  application {
    name     = "admin-ui"
    endpoint = "receive-ca-cert"
  }
  model_uuid = juju_model.iam.uuid
}