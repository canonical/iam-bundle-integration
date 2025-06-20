## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_juju"></a> [juju](#requirement\_juju) | >= 0.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_juju"></a> [juju](#provider\_juju) | 0.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kratos_external_idp_integrator"></a> [kratos\_external\_idp\_integrator](#module\_kratos\_external\_idp\_integrator) | ../external_idp_integrator | n/a |

## Resources

| Name | Type |
|------|------|
| [juju_application.admin_ui](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_application.openfga](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_integration.admin_ui_public_ingress](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.hydra_admin_ui_info](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.hydra_admin_ui_oauth](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.kratos_admin_ui_info](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.kratos_external_idp](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.oauth_ca_admin_ui](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.openfga_admin_ui](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.openfga_db](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_offer.openfga_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.ca_certificate](https://registry.terraform.io/providers/juju/juju/latest/docs/data-sources/offer) | data source |
| [juju_offer.database](https://registry.terraform.io/providers/juju/juju/latest/docs/data-sources/offer) | data source |
| [juju_offer.ingress](https://registry.terraform.io/providers/juju/juju/latest/docs/data-sources/offer) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_ui"></a> [admin\_ui](#input\_admin\_ui) | The configurations of the Identity Platform Admin UI application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_hydra_name"></a> [hydra\_name](#input\_hydra\_name) | Hydra charm name. The default value assumes extra module is deployed in the same Juju model. | `string` | `"hydra"` | no |
| <a name="input_idp_provider_config"></a> [idp\_provider\_config](#input\_idp\_provider\_config) | The external IdP provider configurations. | <pre>object({<br/>    client_id : string<br/>    issuer_url : optional(string)<br/>    provider : string<br/>    provider_id : string<br/>    scope : optional(string, "profile email address phone")<br/>    microsoft_tenant_id : optional(string)<br/>    apple_team_id : optional(string)<br/>    apple_private_key_id : optional(string)<br/>  })</pre> | <pre>{<br/>  "client_id": "client_id",<br/>  "provider": "generic",<br/>  "provider_id": "provider_id"<br/>}</pre> | no |
| <a name="input_idp_provider_credentials"></a> [idp\_provider\_credentials](#input\_idp\_provider\_credentials) | The external IdP provider credentials. | <pre>object({<br/>    client_secret : string<br/>    apple_private_key : optional(string)<br/>  })</pre> | <pre>{<br/>  "client_secret": "client_secret"<br/>}</pre> | no |
| <a name="input_ingress_offer_url"></a> [ingress\_offer\_url](#input\_ingress\_offer\_url) | Ingress Offer URL | `string` | `"admin/core.ingress"` | no |
| <a name="input_kratos_name"></a> [kratos\_name](#input\_kratos\_name) | Kratos charm name. The default value assumes extra module is deployed in the same Juju model. | `string` | `"kratos"` | no |
| <a name="input_model"></a> [model](#input\_model) | The name of the Juju model to deploy to. | `string` | `"iam"` | no |
| <a name="input_openfga"></a> [openfga](#input\_openfga) | The configurations of the OpenFGA application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_postgresql_offer_url"></a> [postgresql\_offer\_url](#input\_postgresql\_offer\_url) | PostgreSQL Offer URL | `string` | `"admin/core.postgresql"` | no |
| <a name="input_send_ca_certificate_offer_url"></a> [send\_ca\_certificate\_offer\_url](#input\_send\_ca\_certificate\_offer\_url) | Send CA Certificate Offer URL | `string` | `"admin/core.send-ca-cert"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_openfga_offer_url"></a> [openfga\_offer\_url](#output\_openfga\_offer\_url) | The OpenFGA Juju offer resource. |
