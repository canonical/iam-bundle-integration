resource "juju_model" "core" {
  name = "core"
}

module "certificates" {
  source = "github.com/canonical/self-signed-certificates-operator//terraform?ref=rev443"

  model_uuid = juju_model.core.uuid
  app_name   = "self-signed-certificates"

  config  = var.certificates.config
  units   = var.certificates.units
  channel = var.certificates.channel
  base    = var.certificates.base

  depends_on = [juju_model.core]
}

module "traefik" {
  source = "github.com/canonical/traefik-k8s-operator//terraform?ref=rev259"

  model_uuid = juju_model.core.uuid
  app_name   = "traefik-public"

  config  = var.traefik.config
  units   = var.traefik.units
  channel = var.traefik.channel

  depends_on = [juju_model.core, module.certificates]
}

module "postgresql" {
  source = "github.com/canonical/postgresql-k8s-operator//terraform?ref=6bb4c2b"

  juju_model = juju_model.core.uuid
  app_name   = "postgresql-k8s"

  units   = var.postgresql.units
  config  = var.postgresql.config
  channel = var.postgresql.channel
  base    = var.postgresql.base

  storage_directives = {
    pgdata = "10G"
  }

  depends_on = [juju_model.core]
}

module "openfga" {
  source = "github.com/canonical/openfga-operator//terraform?ref=v1.6.2"

  model    = juju_model.core.uuid
  app_name = "openfga-k8s"

  config  = var.openfga.config
  units   = var.openfga.units
  channel = var.openfga.channel

  depends_on = [juju_model.core, module.postgresql]
}

resource "juju_model" "iam" {
  name = "iam"
}

module "iam" {
  source = "../../"
  model  = juju_model.iam.uuid

  postgresql_offer_url          = juju_offer.postgresql.url
  traefik_route_offer_url       = juju_offer.traefik_route.url
  send_ca_certificate_offer_url = juju_offer.send_ca_certificate.url

  hydra                                 = var.hydra
  kratos                                = var.kratos
  login_ui                              = var.login_ui
  kratos_external_idp_integrator        = var.kratos_external_idp_integrator
  enable_kratos_external_idp_integrator = var.enable_kratos_external_idp_integrator

  depends_on = [juju_model.iam]
}

resource "juju_secret" "hook_service_salesforce_credentials" {
  name = "hook_service_salesforce_credentials"
  value = {
    consumer-key    = var.hook_service_consumer_key
    consumer-secret = var.hook_service_consumer_secret
  }
  info       = "The credentials for calling the Salesforce API"
  model_uuid = juju_model.iam.uuid
}

resource "juju_access_secret" "hook_service_salesforce_credentials_access" {
  applications = [module.hook_service.app_name]
  secret_id    = juju_secret.hook_service_salesforce_credentials.secret_id
  model_uuid   = juju_model.iam.uuid
}

module "hook_service" {
  source = "git::https://github.com/canonical/hook-service-operator//terraform?ref=v1.0.6"

  model = juju_model.iam.uuid

  app_name                         = var.hook_service.name
  channel                          = var.hook_service.channel
  base                             = var.hook_service.base
  revision                         = var.hook_service.revision
  salesforce_credentials_secret_id = juju_secret.hook_service_salesforce_credentials.secret_id
  config                           = var.hook_service.config

  depends_on = [juju_access_secret.hook_service_salesforce_credentials_access]
}


