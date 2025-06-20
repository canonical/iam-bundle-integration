module "kratos_external_idp_integrator" {
  source = "../external_idp_integrator"

  model  = var.model
  name   = "kratos-external-idp-integrator"
  config = merge(var.idp_provider_config, var.idp_provider_credentials)
}

resource "juju_application" "openfga" {
  model = var.model
  name  = "openfga-k8s"
  trust = var.openfga.trust
  units = var.openfga.units

  charm {
    name    = "openfga-k8s"
    channel = var.openfga.channel
    base    = var.openfga.base
  }

  config = var.openfga.config
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
}
