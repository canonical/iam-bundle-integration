module "postgresql" {
  source = "./modules/postgresql"

  model = var.model
  name  = "postgresql"
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
    base    = var.kratos.base
  }

  config = var.kratos.config

  depends_on = [module.postgresql, module.kratos_external_idp_integrator]
}

resource "juju_application" "hydra" {
  model = var.model
  name  = "hydra"
  trust = var.hydra.trust
  units = var.hydra.units

  charm {
    name    = "hydra"
    channel = var.hydra.channel
    base    = var.hydra.base
  }

  config = var.hydra.config

  depends_on = [module.postgresql]
}

resource "juju_application" "login_ui" {
  model = var.model
  name  = "login-ui"
  trust = var.login_ui.trust
  units = var.login_ui.units

  charm {
    name    = "identity-platform-login-ui-operator"
    channel = var.login_ui.channel
    base    = var.login_ui.base
  }

  config = var.login_ui.config

  depends_on = [juju_application.hydra, juju_application.kratos]
}

resource "juju_application" "admin_ui" {
  model = var.model
  name  = "admin-ui"
  trust = var.admin_ui.trust
  units = var.admin_ui.units

  charm {
    name    = "identity-platform-admin-ui"
    channel = var.admin_ui.channel
    base    = var.admin_ui.base
  }

  config = var.admin_ui.config

  depends_on = [juju_application.hydra, juju_application.kratos, juju_application.openfga]
}

resource "juju_application" "openfga" {
  model = var.model
  name  = "openfga"
  trust = var.openfga.trust
  units = var.openfga.units

  charm {
    name    = "openfga-k8s"
    channel = var.openfga.channel
    base    = var.openfga.base
  }

  config = var.openfga.config

  depends_on = [module.postgresql]
}
