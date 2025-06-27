output "oauth_offer_url" {
  description = "The Hydra OAuth Juju offer resource."
  value       = juju_offer.oauth_offer.url
}

output "kratos_info_offer_url" {
  description = "The kratos-info Juju offer resource."
  value       = juju_offer.kratos_info_offer.url
}

output "openfga_offer_url" {
  description = "The OpenFGA Juju offer resource."
  value       = length(juju_offer.openfga_offer) > 0 ? juju_offer.openfga_offer[0].url : null
}
