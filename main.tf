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
