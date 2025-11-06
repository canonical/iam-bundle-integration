data "juju_offer" "send_ca_certificate_offer" {
  url = var.send_ca_certificate_offer_url
}

data "juju_offer" "ingress_offer" {
  url = var.ingress_offer_url
}


resource "juju_model" "core" {
  name = "core"
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

resource "juju_model" "iam" {
  name = "iam"
}

module "iam" {
  source = "../../"
  model  = juju_model.iam.name

  postgresql_offer_url          = juju_offer.postgresql_offer.url
  ingress_offer_url             = juju_offer.ingress_offer.url
  send_ca_certificate_offer_url = data.juju_offer.send_ca_certificate_offer.url
  openfga_offer_url             = null

  hydra                                 = var.hydra
  kratos                                = var.kratos
  login_ui                              = var.login_ui
  admin_ui                              = var.admin_ui
  kratos_external_idp_integrator        = var.kratos_external_idp_integrator
  enable_admin_ui                       = var.enable_admin_ui
  enable_kratos_external_idp_integrator = var.enable_kratos_external_idp_integrator

  depends_on = [ juju_model.iam ]
}
