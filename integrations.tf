locals {
  integration_mappings = [
    {
      provider          = module.postgresql.name
      provider_endpoint = "database"
      requirers = [
        juju_application.kratos.name, juju_application.hydra.name
      ]
      requirer_endpoint = "pg-database"
    },
    {
      provider          = module.public_ingress.name
      provider_endpoint = "ingress"
      requirers = [
        juju_application.kratos.name, juju_application.hydra.name
      ]
      requirer_endpoint = "public-ingress"
    },
    {
      provider          = module.public_ingress.name
      provider_endpoint = "ingress"
      requirers         = [juju_application.login_ui.name]
      requirer_endpoint = "ingress"
    },
    {
      provider          = module.admin_ingress.name
      provider_endpoint = "ingress"
      requirers = [
        juju_application.kratos.name, juju_application.hydra.name
      ]
      requirer_endpoint = "admin-ingress"
    },
    {
      provider          = module.kratos_external_idp_integrator.name
      provider_endpoint = "kratos-external-idp"
      requirers         = [juju_application.kratos.name]
      requirer_endpoint = "kratos-external-idp"
    },
    {
      provider          = juju_application.hydra.name
      provider_endpoint = "hydra-endpoint-info"
      requirers = [
        juju_application.kratos.name, juju_application.login_ui.name
      ]
      requirer_endpoint = "hydra-endpoint-info"
    },
    {
      provider          = juju_application.kratos.name
      provider_endpoint = "kratos-endpoint-info"
      requirers         = [juju_application.login_ui.name]
      requirer_endpoint = "kratos-endpoint-info"
    },
    {
      provider          = juju_application.login_ui.name
      provider_endpoint = "ui-endpoint-info"
      requirers = [
        juju_application.kratos.name, juju_application.hydra.name
      ]
      requirer_endpoint = "ui-endpoint-info"
    },
  ]
  integrations = flatten([
    for mapping in local.integration_mappings : [
      for requirer in toset(mapping.requirers) : {
        provider          = mapping.provider
        provider_endpoint = mapping.provider_endpoint
        requirer          = requirer
        requirer_endpoint = mapping.requirer_endpoint
      }
    ]
  ])
}

resource "juju_integration" "integration" {
  for_each = {
    for idx, integration in local.integrations : idx => integration
  }

  model = var.model

  application {
    name     = each.value.provider
    endpoint = each.value.provider_endpoint
  }

  application {
    name     = each.value.requirer
    endpoint = each.value.requirer_endpoint
  }
}
