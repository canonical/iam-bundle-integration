resource "juju_application" "certificates" {
  model = var.core_model
  name  = "self-signed-certificates"
  trust = var.certificates.trust
  units = var.certificates.units

  charm {
    name    = "self-signed-certificates"
    channel = var.certificates.channel
    base    = var.certificates.base
  }

  config = var.certificates.config
}

resource "juju_application" "traefik" {
  model = var.core_model
  name  = "traefik-public"
  trust = var.traefik.trust
  units = var.traefik.units

  charm {
    name    = "traefik-k8s"
    channel = var.traefik.channel
    base    = var.traefik.base
  }

  config = var.traefik.config

  depends_on = [juju_application.certificates]
}

resource "juju_application" "postgresql" {
  model = var.core_model
  name  = "postgresql-k8s"
  trust = var.postgresql.trust
  units = var.postgresql.units

  charm {
    name    = "postgresql-k8s"
    channel = var.postgresql.channel
    base    = var.postgresql.base
  }

  config = var.postgresql.config
}

resource "juju_application" "openfga" {
  model = var.core_model
  name  = "openfga-k8s"
  trust = var.openfga.trust
  units = var.openfga.units

  charm {
    name    = "openfga-k8s"
    channel = var.openfga.channel
    base    = var.openfga.base
  }

  config = var.openfga.config

  depends_on = [juju_application.postgresql]
}
