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

// ─── SAML Provider Integrations ─────────────────────────────────────────────

resource "juju_integration" "saml_database" {
  application {
    offer_url = juju_offer.postgresql.url
  }

  application {
    name     = module.saml_provider.app_name
    endpoint = module.saml_provider.requires.database
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "saml_public_route" {
  application {
    offer_url = juju_offer.traefik_route.url
  }

  application {
    name     = module.saml_provider.app_name
    endpoint = module.saml_provider.requires.public-route
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "saml_oauth" {
  application {
    offer_url = module.iam.oauth_offer_url
  }

  application {
    name     = module.saml_provider.app_name
    endpoint = module.saml_provider.requires.oauth
  }
  model_uuid = juju_model.iam.uuid
}
