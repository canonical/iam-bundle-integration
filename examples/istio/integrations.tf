resource "juju_offer" "istio_ingress_route" {
  name             = "istio-ingress-route"
  application_name = juju_application.istio_ingress.name
  endpoints        = ["istio-ingress-route"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "postgresql" {
  name             = "postgresql"
  application_name = module.postgresql.application_name
  endpoints        = ["database"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_integration" "istio_ingress_pilot" {
  application {
    name     = juju_application.istio_ingress.name
    endpoint = "istio-pilot"
  }

  application {
    name     = juju_application.istio.name
    endpoint = "istio-pilot"
  }
  model_uuid = juju_model.core.uuid
}

resource "juju_integration" "istio_ingress_certs" {
  application {
    name     = juju_application.istio_ingress.name
    endpoint = "certificates"
  }

  application {
    name     = module.certificates.app_name
    endpoint = "certificates"
  }
  model_uuid = juju_model.core.uuid
}
