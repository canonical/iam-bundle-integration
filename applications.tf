module "postgresql" {
  source = "./modules/postgresql"

  model = var.model
  name  = "postgresql"
}

module "public_ingress" {
  source = "./modules/ingress"

  model = var.model
  name  = "public-ingress"
}

module "admin_ingress" {
  source = "./modules/ingress"

  model = var.model
  name  = "admin-ingress"
}

module "kratos_external_idp_integrator" {
  source = "./modules/external_idp_integrator"

  model  = var.model
  name   = "kratos-external-idp-integrator"
  config = merge(var.idp_provider_config, var.idp_provider_credentials)
}

resource "juju_application" "kratos" {
  model = var.model
  name  = "kratos"
  trust = var.kratos.trust
  units = var.kratos.units

  charm {
    name    = "kratos"
    channel = var.kratos.channel
    series  = var.kratos.series
  }
}

resource "juju_application" "hydra" {
  model = var.model
  name  = "hydra"
  trust = var.hydra.trust
  units = var.hydra.units

  charm {
    name    = "hydra"
    channel = var.hydra.channel
    series  = var.hydra.series
  }
}

resource "juju_application" "login_ui" {
  model = var.model
  name  = "login-ui"
  trust = var.login_ui.trust
  units = var.login_ui.units

  charm {
    name    = "identity-platform-login-ui-operator"
    channel = var.login_ui.channel
    series  = var.login_ui.series
  }
}
