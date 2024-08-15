output "oauth_offer_url" {
  value = juju_offer.oauth_offer.url
}

output "kratos_info_offer_url" {
  value = juju_offer.kratos_info_offer.url
}

output "kratos" {
  value = juju_application.kratos.name
}

output "hydra" {
  value = juju_application.hydra.name
}
