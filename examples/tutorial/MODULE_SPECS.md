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
| <a name="module_core"></a> [core](#module\_core) | ../core | n/a |

## Resources

| Name | Type |
|------|------|
| [juju_application.hydra](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_application.kratos](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_application.login_ui](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_integration.hydra_database](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.hydra_login_ui_ui_info](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.hydra_public_ingress](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.kratos_database](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.kratos_hydra_info](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.kratos_login_ui_info](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.kratos_login_ui_ui_info](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.kratos_public_ingress](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.login_ui_hydra_info](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.login_ui_public_ingress](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_model.iam](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/model) | resource |
| [juju_offer.kratos_info_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.oauth_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hydra"></a> [hydra](#input\_hydra) | The configurations of the Hydra application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>    trust   = optional(string, true)<br/>    config  = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_kratos"></a> [kratos](#input\_kratos) | The configurations of the Kratos application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>    trust   = optional(string, true)<br/>    config  = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_login_ui"></a> [login\_ui](#input\_login\_ui) | The configurations of the Identity Platform Login UI application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hydra_name"></a> [hydra\_name](#output\_hydra\_name) | The name of the Hydra application. |
| <a name="output_ingress_offer_url"></a> [ingress\_offer\_url](#output\_ingress\_offer\_url) | n/a |
| <a name="output_kratos_info_offer_url"></a> [kratos\_info\_offer\_url](#output\_kratos\_info\_offer\_url) | n/a |
| <a name="output_kratos_name"></a> [kratos\_name](#output\_kratos\_name) | The name of the Kratos application. |
| <a name="output_oauth_offer_url"></a> [oauth\_offer\_url](#output\_oauth\_offer\_url) | n/a |
| <a name="output_postgresql_offer_url"></a> [postgresql\_offer\_url](#output\_postgresql\_offer\_url) | n/a |
| <a name="output_send_ca_certificate_offer_url"></a> [send\_ca\_certificate\_offer\_url](#output\_send\_ca\_certificate\_offer\_url) | n/a |
