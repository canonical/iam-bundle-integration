output "postgresql_offer_url" {
  description = "The PostgreSQL Juju offer resource."
  value       = juju_offer.postgresql_offer_url.url
}

output "ingress_offer_url" {
  description = "The Ingress Juju offer resource."
  value       = juju_offer.ingress_offer_url.url
}

output "traefik_route" {
  description = "The Traefik route Juju offer resource."
  value       = juju_offer.traefik_route.url
}

output "send_ca_certificate_offer_url" {
  description = "The certificates Juju offer resource."
  value       = juju_offer.send_ca_certificate_offer_url.url
}

output "openfga_offer_url" {
  description = "The OpenFGA Juju offer resource."
  value       = juju_offer.openfga_offer_url.url
}
