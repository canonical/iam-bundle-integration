// ─── Core cross-model offers ─────────────────────────────────────────────────
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

// ─── Core model integrations ─────────────────────────────────────────────────
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

// ─── IAM public routes ───────────────────────────────────────────────────────
resource "juju_integration" "hydra_public_route" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.traefik_route.url
  }
  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.requires.public-route
  }
}

resource "juju_integration" "kratos_public_route" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.traefik_route.url
  }
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.public-route
  }
}

resource "juju_integration" "login_ui_public_route" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.traefik_route.url
  }
  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.requires.public-route
  }
}

// ─── IAM databases ───────────────────────────────────────────────────────────
resource "juju_integration" "hydra_database" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.postgresql.url
  }
  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.requires.pg-database
  }
}

resource "juju_integration" "kratos_database" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.postgresql.url
  }
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.pg-database
  }
}

resource "juju_integration" "tenant_service_database" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.postgresql.url
  }
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.requires.pg-database
  }
}

// ─── TLS / CA certificates ───────────────────────────────────────────────────
// Note: hydra does not expose a receive-ca-cert endpoint; CA cert is only
// wired to kratos, login-ui, and tenant-service.

resource "juju_integration" "kratos_ca_cert" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.send_ca_certificate.url
  }
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.receive-ca-cert
  }
}

resource "juju_integration" "login_ui_ca_cert" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.send_ca_certificate.url
  }
  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.requires.receive-ca-cert
  }
}

resource "juju_integration" "tenant_service_ca_cert" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.send_ca_certificate.url
  }
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.requires.receive-ca-cert
  }
}

// ─── IAM internal networking ─────────────────────────────────────────────────
resource "juju_integration" "kratos_hydra_endpoint_info" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.provides.hydra-endpoint-info
  }
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.hydra-endpoint-info
  }
}

resource "juju_integration" "login_ui_hydra_endpoint_info" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.hydra.app_name
    endpoint = "hydra-endpoint-info"
  }
  application {
    name = module.login_ui.app_name
  }
}

resource "juju_integration" "login_ui_kratos_info" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.provides.kratos-info
  }
  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.requires.kratos-info
  }
}

resource "juju_integration" "kratos_login_ui_endpoint_info" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.provides.ui-endpoint-info
  }
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.ui-endpoint-info
  }
}

resource "juju_integration" "hydra_login_ui_endpoint_info" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.login_ui.app_name
    endpoint = "ui-endpoint-info"
  }
  application {
    name = module.hydra.app_name
  }
}

// ─── OAuth (Hydra → Tenant Service) ─────────────────────────────────────────
resource "juju_integration" "tenant_service_oauth" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.provides.oauth
  }
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.requires.oauth
  }
}

// ─── OpenFGA (Tenant Service) ────────────────────────────────────────────────
resource "juju_integration" "tenant_service_openfga" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.openfga.url
  }
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.requires.openfga
  }
}

// ─── Kratos info (Kratos → Tenant Service) ───────────────────────────────────
resource "juju_integration" "tenant_service_kratos_info" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.provides.kratos-info
  }
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.requires.kratos-info
  }
}

// ─── Hydra token hook (Hook Service → Hydra) ────────────────────────────────
resource "juju_integration" "hook_service_hydra_token_hook" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.hook_service.app_name
    endpoint = module.hook_service.provides.hydra-token-hook
  }
  application {
    name     = module.hydra.app_name
    endpoint = "hydra-token-hook"
  }
}

// ─── Kratos registration webhook (Tenant Service → Kratos) ───────────────────
resource "juju_integration" "tenant_service_kratos_registration_webhook" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.provides.kratos-registration-webhook
  }
  application {
    name     = module.kratos.app_name
    endpoint = "kratos-registration-webhook"
  }
}

// ─── Kratos login webhook (Tenant Service → Kratos) ──────────────────────────
resource "juju_integration" "tenant_service_kratos_login_webhook" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.provides.kratos-login-webhook
  }
  application {
    name     = module.kratos.app_name
    endpoint = module.kratos.requires.kratos-login-webhook
  }
}

// ─── Tenant service info (Tenant Service → Login UI) ─────────────────────────
resource "juju_integration" "login_ui_tenant_service_info" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.tenant_service.app_name
    endpoint = module.tenant_service.provides.tenant-service-info
  }
  application {
    name     = module.login_ui.app_name
    endpoint = module.login_ui.requires.tenant-service-info
  }
}

// ─── Hook Service integrations ───────────────────────────────────────────────
resource "juju_integration" "hook_service_database" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.postgresql.url
  }
  application {
    name     = module.hook_service.app_name
    endpoint = module.hook_service.requires.pg-database
  }
}

resource "juju_integration" "hook_service_openfga" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.openfga.url
  }
  application {
    name     = module.hook_service.app_name
    endpoint = module.hook_service.requires.openfga
  }
}

resource "juju_integration" "hook_service_ca_cert" {
  model_uuid = juju_model.iam.uuid
  application {
    offer_url = juju_offer.send_ca_certificate.url
  }
  application {
    name     = module.hook_service.app_name
    endpoint = module.hook_service.requires.receive-ca-cert
  }
}

resource "juju_integration" "hook_service_oauth" {
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.hydra.app_name
    endpoint = module.hydra.provides.oauth
  }
  application {
    name     = module.hook_service.app_name
    endpoint = module.hook_service.requires.oauth
  }
}

// ─── Kratos External IdP Integrator → Kratos ─────────────────────────────────
resource "juju_integration" "kratos_external_idp" {
  count      = var.enable_kratos_external_idp_integrator ? 1 : 0
  model_uuid = juju_model.iam.uuid
  application {
    name     = module.kratos_external_idp_integrator[0].app_name
    endpoint = module.kratos_external_idp_integrator[0].provides.kratos-external-idp
  }
  application {
    name     = module.kratos.app_name
    endpoint = "kratos-external-idp"
  }
}
