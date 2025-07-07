resource "juju_model" "core" {
  name = "core"
}

module "certificates" {
  source = "github.com/canonical/self-signed-certificates-operator//terraform?ref=rev317"

  model    = juju_model.core.name
  app_name = "self-signed-certificates"

  config  = var.certificates.config
  units   = var.certificates.units
  channel = var.certificates.channel
  base    = var.certificates.base

  depends_on = [juju_model.core]
}

module "traefik" {
  source = "github.com/canonical/traefik-k8s-operator//terraform?ref=main"

  model    = juju_model.core.name
  app_name = "traefik-public"

  config  = var.traefik.config
  units   = var.traefik.units
  channel = var.traefik.channel

  depends_on = [juju_model.core, module.certificates]
}

module "postgresql" {
  source = "github.com/canonical/postgresql-k8s-operator//terraform?ref=rev495"

  juju_model_name = juju_model.core.name
  app_name        = "postgresql-k8s"

  units   = var.postgresql.units
  config  = var.postgresql.config
  channel = var.postgresql.channel
  base    = var.postgresql.base

  depends_on = [juju_model.core]
}

resource "juju_application" "openfga" {
  model = juju_model.core.name
  count = var.enable_admin_ui ? 1 : 0
  name  = "openfga-k8s"
  trust = var.openfga.trust
  units = var.openfga.units

  charm {
    name    = "openfga-k8s"
    channel = var.openfga.channel
    base    = var.openfga.base
  }

  config = var.openfga.config

  depends_on = [juju_model.core, module.postgresql]
}

resource "juju_model" "iam" {
  name = "iam"
}

module "iam" {
  source = "../../"
  model  = juju_model.iam.name

  postgresql_offer_url          = juju_offer.postgresql_offer.url
  ingress_offer_url             = juju_offer.ingress_offer.url
  send_ca_certificate_offer_url = juju_offer.send_ca_certificate_offer.url
  openfga_offer_url             = var.enable_admin_ui ? juju_offer.openfga_offer[0].url : null

  hydra                                 = var.hydra
  kratos                                = var.kratos
  login_ui                              = var.login_ui
  admin_ui                              = var.admin_ui
  kratos_external_idp_integrator        = var.kratos_external_idp_integrator
  enable_admin_ui                       = var.enable_admin_ui
  enable_kratos_external_idp_integrator = var.enable_kratos_external_idp_integrator

  depends_on = [ juju_model.iam ]
}
