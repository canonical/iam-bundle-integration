// ─── Core model ─────────────────────────────────────────────────────────────
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
  source = "github.com/canonical/postgresql-k8s-operator//terraform?ref=v16/1.153.0"

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

// ─── IAM model ──────────────────────────────────────────────────────────────
resource "juju_model" "iam" {
  name = "iam"
}

module "iam" {
  source = "../../"
  model  = juju_model.iam.uuid

  postgresql_offer_url    = juju_offer.postgresql.url
  traefik_route_offer_url = juju_offer.traefik_route.url

  hydra                                 = var.hydra
  kratos                                = var.kratos
  login_ui                              = var.login_ui
  kratos_external_idp_integrator        = var.kratos_external_idp_integrator
  enable_kratos_external_idp_integrator = var.enable_kratos_external_idp_integrator

  depends_on = [juju_model.iam]
}

// ─── SAML Provider Secrets ──────────────────────────────────────────────────
resource "juju_secret" "saml_credentials" {
  name = "saml-credentials"
  value = {
    public-cert = var.saml_public_cert
    private-key = var.saml_private_key
  }
  info       = "The credentials (public-cert and private-key) for SAML assertions signing"
  model_uuid = juju_model.iam.uuid
}

resource "juju_access_secret" "saml_credentials_access" {
  applications = [var.identity_saml_provider.name]
  secret_id    = juju_secret.saml_credentials.secret_id
  model_uuid   = juju_model.iam.uuid
}

// ─── SAML Provider ──────────────────────────────────────────────────────────
module "saml_provider" {
  source = "github.com/canonical/identity-saml-provider-operator//terraform?ref=v1.0.3"

  model    = juju_model.iam.uuid
  app_name = var.identity_saml_provider.name
  channel  = var.identity_saml_provider.channel
  base     = var.identity_saml_provider.base
  units    = var.identity_saml_provider.units

  config = merge(
    var.identity_saml_provider.config,
    {
      saml_credentials = juju_secret.saml_credentials.secret_id
    }
  )

  depends_on = [juju_access_secret.saml_credentials_access, module.iam]
}
