// public ingresses
resource "juju_integration" "login_ui_public_ingress" {
  model = var.model

  application {
    name     = var.external_ingress.name
    endpoint = var.external_ingress.endpoint
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "hydra_public_ingress" {
  model = var.model

  application {
    name     = var.external_ingress.name
    endpoint = var.external_ingress.endpoint
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "public-ingress"
  }
}

resource "juju_integration" "kratos_public_ingress" {
  model = var.model

  application {
    name     = var.external_ingress.name
    endpoint = var.external_ingress.endpoint
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "public-ingress"
  }
}

// databases

resource "juju_integration" "hydra_database" {
  model = var.model

  application {
    name     = module.postgresql.name
    endpoint = "database"
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "pg-database"
  }
}

resource "juju_integration" "kratos_database" {
  model = var.model

  application {
    name     = module.postgresql.name
    endpoint = "database"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "pg-database"
  }
}

// idp

resource "juju_integration" "kratos_external_idp" {
  model = var.model

  application {
    name     = module.kratos_external_idp_integrator.name
    endpoint = "kratos-external-idp"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "kratos-external-idp"
  }
}

// internal networking

resource "juju_integration" "kratos_hydra_info" {
  model = var.model

  application {
    name     = juju_application.hydra.name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "login_ui_hydra_info" {
  model = var.model

  application {
    name     = juju_application.hydra.name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "kratos_login_ui_info" {
  model = var.model

  application {
    name     = juju_application.login_ui.name
    endpoint = "kratos-endpoint-info"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "kratos-endpoint-info"
  }
}

resource "juju_integration" "kratos_login_ui_ui_info" {
  model = var.model

  application {
    name     = juju_application.kratos.name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ui-endpoint-info"
  }
}

resource "juju_integration" "hydra_login_ui_ui_info" {
  model = var.model

  application {
    name     = juju_application.hydra.name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = juju_application.login_ui.name
    endpoint = "ui-endpoint-info"
  }
}
