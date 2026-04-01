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

resource "juju_integration" "user_verification_service_public_traefik_route" {
  model_uuid = juju_model.iam.uuid

  application {
    offer_url = juju_offer.traefik_route.url
  }

  application {
    name     = module.user_verification_service.app_name
    endpoint = "ingress"
  }

}

resource "juju_integration" "kratos_user_verification_service_ui_info" {
  application {
    name     = "kratos"
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = module.user_verification_service.app_name
    endpoint = "registration-endpoint-info"
  }

  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "kratos_user_verification_service_registration_webhook" {
  application {
    name     = "kratos"
    endpoint = "kratos-registration-webhook"
  }

  application {
    name     = module.user_verification_service.app_name
    endpoint = "kratos-registration-webhook"
  }

  model_uuid = juju_model.iam.uuid
}

resource "juju_integration" "login_ui_user_verification_service_ui_endpoint_info" {
  application {
    name     = "login-ui"
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = module.user_verification_service.app_name
    endpoint = "ui-endpoint-info"
  }

  model_uuid = juju_model.iam.uuid
}