resource "juju_offer" "ingress_offer" {
  model            = juju_model.core.name
  name             = "ingress"
  application_name = module.traefik.app_name
  endpoints        = ["ingress"]
}

resource "juju_offer" "traefik_route_offer" {
  model            = juju_model.core.name
  name             = "traefik-route"
  application_name = module.traefik.app_name
  endpoints        = ["traefik-route"]
}

resource "juju_offer" "postgresql_offer" {
  model            = juju_model.core.name
  name             = "postgresql"
  application_name = module.postgresql.application_name
  endpoints        = ["database"]
}

resource "juju_offer" "send_ca_certificate_offer" {
  model            = juju_model.core.name
  name             = "send-ca-cert"
  application_name = module.certificates.app_name
  endpoints        = ["send-ca-cert"]
}

resource "juju_integration" "traefik_certs" {
  model = juju_model.core.name
  application {
    name     = module.traefik.app_name
    endpoint = "certificates"
  }

  application {
    name     = module.certificates.app_name
    endpoint = "certificates"
  }
}
