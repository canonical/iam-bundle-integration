output "postgresql_offer_url" {
  description = "The PostgreSQL Juju offer resource."
  value = module.core.postgresql_offer_url
}

output "ingress_offer_url" {
  description = "The Ingress Juju offer resource."
  value = module.core.ingress_offer_url
}

output "send_ca_certificate_offer_url" {
  description = "The send-ca-certificates Juju offer resource."
  value = module.core.send_ca_certificate_offer_url
}

output "oauth_offer_url" {
  description = "The Hydra OAuth Juju offer resource."
  value = juju_offer.oauth_offer.url
}

output "kratos_info_offer_url" {
  description = "The kratos-info Juju offer resource."
  value = juju_offer.kratos_info_offer.url
}

output "hydra_name" {
  description = "The name of the Hydra application."
  value       = juju_application.hydra.name
}

output "kratos_name" {
  description = "The name of the Kratos application."
  value       = juju_application.kratos.name
}
