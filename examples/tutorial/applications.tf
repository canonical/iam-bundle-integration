resource "juju_application" "kratos" {
  model = juju_model.iam.name
  name  = "kratos"
  trust = var.kratos.trust
  units = var.kratos.units

  charm {
    name    = "kratos"
    channel = var.kratos.channel
    base    = var.kratos.base
  }

  config = var.kratos.config

  depends_on = [juju_model.iam]
}

resource "juju_application" "hydra" {
  model = juju_model.iam.name
  name  = "hydra"
  trust = var.hydra.trust
  units = var.hydra.units

  charm {
    name    = "hydra"
    channel = var.hydra.channel
    base    = var.hydra.base
  }

  config = var.hydra.config

  depends_on = [juju_model.iam]
}

resource "juju_application" "login_ui" {
  model = juju_model.iam.name
  name  = "login-ui"
  trust = var.login_ui.trust
  units = var.login_ui.units

  charm {
    name    = "identity-platform-login-ui-operator"
    channel = var.login_ui.channel
    base    = var.login_ui.base
  }

  config = var.login_ui.config

  depends_on = [juju_model.iam, juju_application.hydra, juju_application.kratos]
}
