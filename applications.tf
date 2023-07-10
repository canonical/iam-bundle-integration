module "postgresql" {
  source = "./modules/postgresql"

  model = juju_model.iam_bundle.name
  name  = "postgresql"
}

module "public_ingress" {
  source = "./modules/ingress"

  model = juju_model.iam_bundle.name
  name  = "public-ingress"
}

module "admin_ingress" {
  source = "./modules/ingress"

  model = juju_model.iam_bundle.name
  name  = "admin-ingress"
}

module "kratos_external_idp_integrator" {
  source = "./modules/external_idp_integrator"

  model  = juju_model.iam_bundle.name
  name   = "kratos-external-idp-integrator"
  config = merge(var.idp_provider_config, var.idp_provider_credentials)
}

resource "juju_application" "kratos" {
  model = juju_model.iam_bundle.name
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
  model = juju_model.iam_bundle.name
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
  model = juju_model.iam_bundle.name
  name  = "login-ui"
  trust = var.login_ui.trust
  units = var.login_ui.units

  charm {
    name    = "identity-platform-login-ui-operator"
    channel = var.login_ui.channel
    series  = var.login_ui.series
  }
}
