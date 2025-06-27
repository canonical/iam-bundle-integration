resource "juju_offer" "oauth_offer" {
  name             = "oauth-offer"
  model            = var.model
  application_name = juju_application.hydra.name
  endpoints        = ["oauth"]
}

resource "juju_offer" "kratos_info_offer" {
  name             = "kratos-info-offer"
  model            = var.model
  application_name = juju_application.kratos.name
  endpoints        = ["kratos-info"]
}

resource "juju_offer" "openfga_offer_url" {
  name             = "openfga-offer"
  model            = var.model
  count            = var.deploy_openfga ? 1 : 0
  application_name = juju_application.openfga[0].name
  endpoints        = ["openfga"]
}
