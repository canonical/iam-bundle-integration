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

module "istio" {
  source = "git::https://github.com/canonical/istio-k8s-operator//terraform?ref=track/2"

  model_uuid = juju_model.core.uuid
  app_name   = "istio-k8s"

  config  = var.istio.config
  units   = var.istio.units
  channel = var.istio.channel

  depends_on = [juju_model.core]
}

module "istio_ingress" {
  source = "git::https://github.com/canonical/istio-ingress-k8s-operator//terraform?ref=track/2"

  model_uuid = juju_model.core.uuid
  app_name   = "istio-ingress-k8s"

  config  = var.istio_ingress.config
  units   = var.istio_ingress.units
  channel = var.istio_ingress.channel

  depends_on = [juju_model.core]
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

resource "juju_model" "iam" {
  name = "iam"
}

module "iam" {
  source = "../../"
  model  = juju_model.iam.uuid

  postgresql_offer_url  = juju_offer.postgresql.url
  istio_route_offer_url = juju_offer.istio_ingress_route.url

  hydra                                 = var.hydra
  kratos                                = var.kratos
  login_ui                              = var.login_ui
  kratos_external_idp_integrator        = var.kratos_external_idp_integrator
  enable_kratos_external_idp_integrator = var.enable_kratos_external_idp_integrator

  depends_on = [juju_model.iam]
}
