output "oauth_offer_url" {
  description = "The Hydra OAuth Juju offer resource."
  value       = juju_offer.oauth_offer.url
}

output "kratos_info_offer_url" {
  description = "The kratos-info Juju offer resource."
  value       = juju_offer.kratos_info_offer.url
}
