resource "juju_application" "certificates" {
  model = juju_model.core.name
  name  = "self-signed-certificates"
  trust = var.certificates.trust
  units = var.certificates.units

  charm {
    name    = "self-signed-certificates"
    channel = var.certificates.channel
    base    = var.certificates.base
  }

  config = var.certificates.config

  depends_on = [juju_model.core]
}

resource "juju_application" "traefik" {
  model = juju_model.core.name
  name  = "traefik-public"
  trust = var.traefik.trust
  units = var.traefik.units

  charm {
    name    = "traefik-k8s"
    channel = var.traefik.channel
    base    = var.traefik.base
  }

  config = var.traefik.config

  depends_on = [juju_model.core, juju_application.certificates]
}

resource "juju_application" "postgresql" {
  model = juju_model.core.name
  name  = "postgresql-k8s"
  trust = var.postgresql.trust
  units = var.postgresql.units

  charm {
    name    = "postgresql-k8s"
    channel = var.postgresql.channel
    base    = var.postgresql.base
  }

  config = var.postgresql.config

  depends_on = [juju_model.core]
}
