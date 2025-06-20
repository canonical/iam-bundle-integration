resource "juju_integration" "openfga_db" {
  model = var.core_model
  application {
    name = juju_application.openfga.name
  }
  application {
    name = juju_application.postgresql.name
  }
}

resource "juju_integration" "traefik_certs" {
  model = var.core_model
  application {
    name = juju_application.traefik.name
    endpoint = "receive-ca-cert"
  }

  application {
    name = juju_application.certificates.name
    endpoint = "send-ca-cert"
  }
}

resource "juju_offer" "ingress_offer_url" {
  model   = var.core_model
  name    = "ingress"
  application_name = juju_application.traefik.name
  endpoint = "ingress"
}

resource "juju_offer" "traefik_route" {
  model   = var.core_model
  name    = "traefik-route"
  application_name = juju_application.traefik.name
  endpoint = "traefik-route"
}

resource "juju_offer" "postgresql_offer_url" {
  model   = var.core_model
  name    = "postgresql"
  application_name = juju_application.postgresql.name
  endpoint = "database"
}

resource "juju_offer" "openfga_offer_url" {
  model   = var.core_model
  name    = "openfga"
  application_name = juju_application.openfga.name
  endpoint = "openfga"
}

resource "juju_offer" "send_ca_certificate_offer_url" {
  model   = var.core_model
  name    = "send-ca-cert"
  application_name = juju_application.certificates.name
  endpoint = "send-ca-cert"
}
