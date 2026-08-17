resource "juju_offer" "istio_ingress_route" {
  name             = "istio-ingress-route"
  application_name = module.istio_ingress.app_name
  endpoints        = ["istio-ingress-route"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_offer" "postgresql" {
  name             = "postgresql"
  application_name = module.postgresql.application_name
  endpoints        = ["database"]
  model_uuid       = juju_model.core.uuid
}

resource "juju_integration" "istio_ingress_certs" {
  application {
    name     = module.istio_ingress.app_name
    endpoint = "certificates"
  }

  application {
    name     = module.certificates.app_name
    endpoint = "certificates"
  }
  model_uuid = juju_model.core.uuid
}

resource "juju_integration" "istio_ingress_config" {
  application {
    name     = module.istio.app_name
    endpoint = "istio-ingress-config"
  }

  application {
    name     = module.istio_ingress.app_name
    endpoint = "istio-ingress-config"
  }
  model_uuid = juju_model.core.uuid
}

resource "juju_integration" "login_ui_istio_ingress_route" {
  model_uuid = juju_model.iam.uuid

  application {
    offer_url = juju_offer.istio_ingress_route.url
  }

  application {
    name     = "login-ui"
    endpoint = "istio-ingress-route"
  }
}

resource "juju_integration" "hydra_istio_ingress_route" {
  model_uuid = juju_model.iam.uuid

  application {
    offer_url = juju_offer.istio_ingress_route.url
  }

  application {
    name     = "hydra"
    endpoint = "istio-ingress-route"
  }
}

resource "juju_integration" "kratos_istio_ingress_route" {
  model_uuid = juju_model.iam.uuid

  application {
    offer_url = juju_offer.istio_ingress_route.url
  }

  application {
    name     = "kratos"
    endpoint = "istio-ingress-route"
  }
}