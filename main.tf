resource "juju_offer" "oauth_offer" {
  name             = "oauth-offer"
  model            = var.model
  application_name = juju_application.hydra.name
  endpoint         = "oauth"
}
