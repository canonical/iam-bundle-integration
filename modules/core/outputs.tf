output "postgresql_offer_url" {
  description = "The PostgreSQL Juju offer resource."
  value       = juju_offer.postgresql_offer.url
}

output "ingress_offer_url" {
  description = "The Ingress Juju offer resource."
  value       = juju_offer.ingress_offer.url
}

output "traefik_route_offer_url" {
  description = "The Traefik route Juju offer resource."
  value       = juju_offer.traefik_route_offer.url
}

output "send_ca_certificate_offer_url" {
  description = "The certificates Juju offer resource."
  value       = juju_offer.send_ca_certificate_offer.url
}
