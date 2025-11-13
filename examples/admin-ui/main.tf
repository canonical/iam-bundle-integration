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
  source = "github.com/shipperizer/postgresql-k8s-operator//terraform?ref=juju-tf%2F1.0"

  juju_model = juju_model.core.uuid
  app_name   = "postgresql-k8s"

  units   = var.postgresql.units
  config  = var.postgresql.config
  channel = var.postgresql.channel
  base    = var.postgresql.base

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
  ingress_offer_url             = juju_offer.ingress.url
  send_ca_certificate_offer_url = juju_offer.send_ca_certificate.url

  hydra                                 = var.hydra
  kratos                                = var.kratos
  login_ui                              = var.login_ui
  kratos_external_idp_integrator        = var.kratos_external_idp_integrator
  enable_kratos_external_idp_integrator = var.enable_kratos_external_idp_integrator

  depends_on = [juju_model.iam]
}

module "admin_ui" {
  source = "github.com/canonical/identity-platform-admin-ui-operator//terraform?ref=b1b3c2a"

  model       = juju_model.iam.uuid
  app_name    = "admin-ui"
  units       = var.admin_ui.units
  base        = var.admin_ui.base
  channel     = var.admin_ui.channel
  constraints = var.admin_ui.constraints
  revision    = var.admin_ui.revision

  config = var.admin_ui.config

  depends_on = [module.iam]
}
