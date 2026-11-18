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

resource "juju_application" "istio" {
  name       = var.istio.name
  model_uuid = juju_model.core.uuid
  trust      = var.istio.trust
  units      = var.istio.units
  config     = var.istio.config

  charm {
    name     = "istio-k8s"
    channel  = var.istio.channel
    base     = var.istio.base
    revision = var.istio.revision
  }

  depends_on = [juju_model.core]
}

resource "juju_application" "istio_ingress" {
  name       = var.istio_ingress.name
  model_uuid = juju_model.core.uuid
  trust      = var.istio_ingress.trust
  units      = var.istio_ingress.units
  config     = var.istio_ingress.config

  charm {
    name     = "istio-ingress-k8s"
    channel  = var.istio_ingress.channel
    base     = var.istio_ingress.base
    revision = var.istio_ingress.revision
  }

  depends_on = [juju_model.core, juju_application.istio, module.certificates]
}

module "postgresql" {
  source = "github.com/canonical/postgresql-k8s-operator//terraform?ref=v16/1.123.0"

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

  postgresql_offer_url    = juju_offer.postgresql.url
  traefik_route_offer_url = juju_offer.istio_ingress_route.url

  hydra                                 = var.hydra
  kratos                                = var.kratos
  login_ui                              = var.login_ui
  kratos_external_idp_integrator        = var.kratos_external_idp_integrator
  enable_kratos_external_idp_integrator = var.enable_kratos_external_idp_integrator

  depends_on = [juju_model.iam]
}
