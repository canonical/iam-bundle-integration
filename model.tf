resource "juju_model" "iam_bundle" {
  name = var.model

  cloud {
    name   = var.cloud.name
    region = var.cloud.region
  }

  config = {
    logging-config              = "<root>=INFO"
    no-proxy                    = "jujucharms.com"
    update-status-hook-interval = "5m"
  }
}
