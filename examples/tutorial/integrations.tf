resource "juju_offer" "ingress_offer" {
  name             = "ingress"
  application_name = module.traefik.app_name
  endpoints        = ["ingress"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "traefik_route_offer" {
  name             = "traefik-route"
  application_name = module.traefik.app_name
  endpoints        = ["traefik-route"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "postgresql_offer" {
  name             = "postgresql"
  application_name = module.postgresql.application_name
  endpoints        = ["database"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "send_ca_certificate_offer" {
  name             = "send-ca-cert"
  application_name = module.certificates.app_name
  endpoints        = ["send-ca-cert"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "openfga_offer" {
  count            = var.enable_admin_ui ? 1 : 0
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
  count = var.enable_admin_ui ? 1 : 0

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
