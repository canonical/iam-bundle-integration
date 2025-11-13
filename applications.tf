module "kratos_external_idp_integrator" {
  count = var.enable_kratos_external_idp_integrator ? 1 : 0

  source = "github.com/canonical/kratos-external-idp-integrator//terraform?ref=80ce05e"

  model       = data.juju_model.this.uuid
  app_name    = var.kratos_external_idp_integrator.name
  units       = var.kratos_external_idp_integrator.units
  base        = var.kratos_external_idp_integrator.base
  channel     = var.kratos_external_idp_integrator.channel
  constraints = var.kratos_external_idp_integrator.constraints
  revision    = var.kratos_external_idp_integrator.revision

  config = var.kratos_external_idp_integrator.config
}


module "kratos" {
  source = "github.com/canonical/kratos-operator//terraform?ref=1548cca"

  model       = data.juju_model.this.uuid
  app_name    = var.kratos.name
  units       = var.kratos.units
  base        = var.kratos.base
  channel     = var.kratos.channel
  constraints = var.kratos.constraints
  revision    = var.kratos.revision


  config = var.kratos.config

  depends_on = [module.kratos_external_idp_integrator]
}

module "hydra" {
  source = "github.com/canonical/hydra-operator//terraform?ref=14d6163"

  model       = data.juju_model.this.uuid
  app_name    = var.hydra.name
  units       = var.hydra.units
  base        = var.hydra.base
  channel     = var.hydra.channel
  constraints = var.hydra.constraints
  revision    = var.hydra.revision


  config = var.hydra.config
}


module "login_ui" {
  source = "github.com/canonical/identity-platform-login-ui-operator//terraform?ref=b5ddba4"

  model       = data.juju_model.this.uuid
  app_name    = var.login_ui.name
  units       = var.login_ui.units
  base        = var.login_ui.base
  channel     = var.login_ui.channel
  constraints = var.login_ui.constraints
  revision    = var.login_ui.revision


  config = var.login_ui.config

  depends_on = [module.hydra, module.kratos]
}

module "admin_ui" {
  count = var.enable_admin_ui ? 1 : 0

  source = "github.com/canonical/identity-platform-admin-ui-operator//terraform?ref=b1b3c2a"

  model       = data.juju_model.this.uuid
  app_name    = var.admin_ui.name
  units       = var.admin_ui.units
  base        = var.admin_ui.base
  channel     = var.admin_ui.channel
  constraints = var.admin_ui.constraints
  revision    = var.admin_ui.revision


  config = var.admin_ui.config

  depends_on = [module.hydra, module.kratos]
}
