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

module "openfga" {
  source = "github.com/canonical/openfga-operator//terraform?ref=v1.6.2"

  model    = juju_model.core.uuid
  app_name = "openfga-k8s"

  config  = var.openfga.config
  units   = var.openfga.units
  channel = var.openfga.channel

  depends_on = [juju_model.core, module.postgresql]
}

// ─── IAM model ──────────────────────────────────────────────────────────────
resource "juju_model" "iam" {
  name = "iam"
}

module "hydra" {
  source = "github.com/canonical/hydra-operator//terraform?ref=v3.0.2"

  model       = juju_model.iam.uuid
  app_name    = var.hydra.name
  units       = var.hydra.units
  base        = var.hydra.base
  channel     = var.hydra.channel
  constraints = var.hydra.constraints
  revision    = var.hydra.revision
  config      = var.hydra.config

  depends_on = [juju_model.iam]
}

module "kratos" {
  source = "github.com/canonical/kratos-operator//terraform?ref=v2.2.1"

  model       = juju_model.iam.uuid
  app_name    = var.kratos.name
  units       = var.kratos.units
  base        = var.kratos.base
  channel     = var.kratos.channel
  constraints = var.kratos.constraints
  revision    = var.kratos.revision
  resources   = var.kratos.resources
  config      = var.kratos.config

  depends_on = [juju_model.iam]
}

module "login_ui" {
  source = "github.com/canonical/identity-platform-login-ui-operator//terraform?ref=v2.2.1"

  model       = juju_model.iam.uuid
  app_name    = var.login_ui.name
  units       = var.login_ui.units
  base        = var.login_ui.base
  channel     = var.login_ui.channel
  constraints = var.login_ui.constraints
  revision    = var.login_ui.revision
  resources   = var.login_ui.resources
  config      = var.login_ui.config

  depends_on = [juju_model.iam, module.hydra, module.kratos]
}

module "tenant_service" {
  source = "github.com/canonical/tenant-service-operator//terraform?ref=v1.1.1"

  model     = juju_model.iam.uuid
  app_name  = var.tenant_service.name
  units     = var.tenant_service.units
  base      = var.tenant_service.base
  channel   = var.tenant_service.channel
  revision  = var.tenant_service.revision
  resources = var.tenant_service.resources
  config    = var.tenant_service.config


  depends_on = [juju_model.iam, module.kratos]
}

module "hook_service" {
  source = "github.com/canonical/hook-service-operator//terraform?ref=v1.1.1"

  model    = juju_model.iam.uuid
  app_name = var.hook_service.name
  units    = var.hook_service.units
  base     = var.hook_service.base
  channel  = var.hook_service.channel
  revision = var.hook_service.revision
  config   = var.hook_service.config


  depends_on = [juju_model.iam, module.tenant_service]
}

// Kratos External IdP Integrator (optional)
module "kratos_external_idp_integrator" {
  count  = var.enable_kratos_external_idp_integrator ? 1 : 0
  source = "github.com/canonical/kratos-external-idp-integrator//terraform?ref=v2.1.0"

  model       = juju_model.iam.uuid
  app_name    = var.kratos_external_idp_integrator.name
  units       = var.kratos_external_idp_integrator.units
  base        = var.kratos_external_idp_integrator.base
  channel     = var.kratos_external_idp_integrator.channel
  constraints = var.kratos_external_idp_integrator.constraints
  revision    = var.kratos_external_idp_integrator.revision
  config      = var.kratos_external_idp_integrator.config

  depends_on = [juju_model.iam, module.kratos]
}
