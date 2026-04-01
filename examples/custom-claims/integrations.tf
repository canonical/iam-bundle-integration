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

resource "juju_integration" "hydra_hook_service_token_hook" {
  model_uuid = juju_model.iam.uuid

  application {
    name     = "hydra"
    endpoint = "hydra-token-hook"
  }

  application {
    name     = module.hook_service.app_name
    endpoint = "hydra-token-hook"
  }
}

resource "juju_integration" "hook_service_database" {
  model_uuid = juju_model.iam.uuid

  application {
    offer_url = juju_offer.postgresql.url
  }

  application {
    name     = module.hook_service.app_name
    endpoint = "pg-database"
  }
}

resource "juju_integration" "hook_service_openfga" {
  model_uuid = juju_model.iam.uuid

  application {
    offer_url = juju_offer.openfga.url
  }

  application {
    name     = module.hook_service.app_name
    endpoint = "openfga"
  }
}