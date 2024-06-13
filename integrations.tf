
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
    {
      provider          = var.internal_ingress.name
      provider_endpoint = var.internal_ingress.endpoint
      requirers = [
        juju_application.kratos.name, juju_application.hydra.name
      ]
      requirer_endpoint = "admin-ingress"
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
  // cmi_integration_mapping = [
  //   {
  //     offer_url = var.juju_offers.external_ingress_offer
  //     requirers = [
  //       juju_application.kratos.name, juju_application.hydra.name
  //     ]
  //     requirer_endpoint = "public-ingress"
  //   },
  //   {
  //     offer_url         = var.juju_offers.external_ingress_offer
  //     requirers         = [juju_application.login_ui.name]
  //     requirer_endpoint = "ingress"
  //   },
  // ]
  // cmi_integrations = flatten([
  //   for mapping in local.cmi_integration_mapping : [
  //     for requirer in toset(mapping.requirers) : {
  //       offer_url         = mapping.offer_url
  //       requirer          = requirer
  //       requirer_endpoint = mapping.requirer_endpoint
  //     }
  //   ]
  // ])
}

resource "juju_integration" "integration" {
  for_each = {
    for idx, integration in local.integrations :
    join(",", [
      join(":", [integration.provider, integration.provider_endpoint]),
      join(":", [integration.requirer, integration.requirer_endpoint])
    ]) => integration

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

// resource "juju_integration" "cmi_integration" {
//   for_each = {
//     for idx, integration in local.cmi_integrations :
//     join(",", [
//       integration.offer_url,
//       join(":", [integration.requirer, integration.requirer_endpoint])
//     ]) => integration
//   }

//   model = var.model

//   application {
//     offer_url = each.value.offer_url
//   }

//   application {
//     name     = each.value.requirer
//     endpoint = each.value.requirer_endpoint
//   }
// }

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
