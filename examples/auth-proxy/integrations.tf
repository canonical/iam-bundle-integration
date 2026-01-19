resource "juju_offer" "traefik_route" {
  name             = "traefik-route"
  application_name = module.traefik.app_name
  endpoints        = ["traefik-route"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "ingress" {
  name             = "ingress"
  application_name = module.traefik.app_name
  endpoints        = ["ingress"]
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

resource "juju_integration" "oauth2_proxy_ingress" {
  application {
    name     = module.oauth2_proxy.app_name
    endpoint = "ingress"
  }

  application {
    offer_url = juju_offer.ingress.url
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "oauth2_proxy_oauth" {
  application {
    name     = module.oauth2_proxy.app_name
    endpoint = "oauth"
  }

  application {
    name     = "hydra"
    endpoint = "oauth"
  }
  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "oauth2_proxy_certs" {
  application {
    name     = module.oauth2_proxy.app_name
    endpoint = "receive-ca-cert"
  }

  application {
    offer_url = juju_offer.send_ca_certificate.url
  }
  model_uuid = juju_model.iam.uuid
}
