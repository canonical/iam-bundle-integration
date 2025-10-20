
data "juju_offer" "metrics" {
  count = var.metrics_offer_url != null ? 1 : 0

  url = var.metrics_offer_url
}

data "juju_offer" "tracing" {
  count = var.tracing_offer_url != null ? 1 : 0

  url = var.tracing_offer_url
}

data "juju_offer" "logging" {
  count = var.logging_offer_url != null ? 1 : 0

  url = var.logging_offer_url
}

###### COS integrations #########

resource "juju_integration" "tracing_admin_ui" {
  count = var.tracing_offer_url != null && var.enable_admin_ui ? 1 : 0

  application {
    offer_url = data.juju_offer.tracing[0].url
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "tracing"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "metrics_admin_ui" {
  count = var.metrics_offer_url != null && var.enable_admin_ui ? 1 : 0

  application {
    offer_url = data.juju_offer.metrics[0].url
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "metrics-endpoint"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "logging_admin_ui" {
  count = var.logging_offer_url != null && var.enable_admin_ui ? 1 : 0

  application {
    offer_url = data.juju_offer.logging[0].url
  }

  application {
    name     = module.admin_ui[0].app_name
    endpoint = "logging"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "tracing_login_ui" {
  count = var.tracing_offer_url != null ? 1 : 0

  application {
    offer_url = data.juju_offer.tracing[0].url
  }

  application {
    name     = module.login_ui.app_name
    endpoint = "tracing"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "metrics_login_ui" {
  count = var.metrics_offer_url != null ? 1 : 0

  application {
    offer_url = data.juju_offer.metrics[0].url
  }

  application {
    name     = module.login_ui.app_name
    endpoint = "metrics-endpoint"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "logging_login_ui" {
  count = var.logging_offer_url != null ? 1 : 0

  application {
    offer_url = data.juju_offer.logging[0].url
  }

  application {
    name     = module.login_ui.app_name
    endpoint = "logging"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "tracing_hydra" {
  count = var.tracing_offer_url != null ? 1 : 0


  application {
    offer_url = data.juju_offer.tracing[0].url
  }

  application {
    name     = module.hydra.app_name
    endpoint = "tracing"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "metrics_hydra" {
  count = var.metrics_offer_url != null ? 1 : 0

  application {
    offer_url = data.juju_offer.metrics[0].url
  }

  application {
    name     = module.hydra.app_name
    endpoint = "metrics-endpoint"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "logging_hydra" {
  count = var.logging_offer_url != null ? 1 : 0

  application {
    offer_url = data.juju_offer.logging[0].url
  }

  application {
    name     = module.hydra.app_name
    endpoint = "logging"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "tracing_kratos" {
  count = var.tracing_offer_url != null ? 1 : 0


  application {
    offer_url = data.juju_offer.tracing[0].url
  }

  application {
    name     = module.kratos.app_name
    endpoint = "tracing"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "metrics_kratos" {
  count = var.metrics_offer_url != null ? 1 : 0

  application {
    offer_url = data.juju_offer.metrics[0].url
  }

  application {
    name     = module.kratos.app_name
    endpoint = "metrics-endpoint"
  }
  model_uuid = data.juju_model.this.uuid
}

resource "juju_integration" "logging_kratos" {
  count = var.logging_offer_url != null ? 1 : 0

  application {
    offer_url = data.juju_offer.logging[0].url
  }

  application {
    name     = module.kratos.app_name
    endpoint = "logging"
  }
  model_uuid = data.juju_model.this.uuid
}
