module "kratos_external_idp_integrator" {
  count = var.enable_kratos_external_idp_integrator ? 1 : 0

  source = "github.com/canonical/kratos-external-idp-integrator//terraform?ref=v1.1.1"

  model_name = data.juju_model.this.name
  app_name   = "kratos-external-idp-integrator"
  config     = merge(var.idp_provider_config, var.idp_provider_credentials)
}


module "kratos" {
  source = "github.com/canonical/kratos-operator//terraform?ref=v1.1.8"

  model_name  = data.juju_model.this.name
  app_name    = var.kratos.name
  units       = var.kratos.units
  base        = var.kratos.base
  channel     = var.kratos.channel
  constraints = var.kratos.constraints

  config = var.kratos.config

  depends_on = [module.kratos_external_idp_integrator]
}

module "hydra" {
  source = "github.com/canonical/hydra-operator//terraform?ref=v1.1.7"

  model_name  = data.juju_model.this.name
  app_name    = var.hydra.name
  units       = var.hydra.units
  base        = var.hydra.base
  channel     = var.hydra.channel
  constraints = var.hydra.constraints

  config = var.hydra.config
}


module "login_ui" {
  source = "github.com/canonical/identity-platform-login-ui-operator//terraform?ref=v1.1.4"

  model_name  = data.juju_model.this.name
  app_name    = var.login_ui.name
  units       = var.login_ui.units
  base        = var.login_ui.base
  channel     = var.login_ui.channel
  constraints = var.login_ui.constraints

  config = var.login_ui.config

  depends_on = [module.hydra, module.kratos]
}

module "admin_ui" {
  count = var.enable_admin_ui ? 1 : 0

  source = "github.com/canonical/identity-platform-admin-ui-operator//terraform?ref=v1.1.3"

  model_name  = data.juju_model.this.name
  app_name    = var.admin_ui.name
  units       = var.admin_ui.units
  base        = var.admin_ui.base
  channel     = var.admin_ui.channel
  constraints = var.admin_ui.constraints

  config = var.admin_ui.config

  depends_on = [module.hydra, module.kratos]
}
