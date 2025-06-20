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
| <a name="module_certificates"></a> [certificates](#module\_certificates) | github.com/canonical/self-signed-certificates-operator//terraform | rev317 |
| <a name="module_iam"></a> [iam](#module\_iam) | ../../ | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | github.com/canonical/postgresql-k8s-operator//terraform | rev495 |
| <a name="module_traefik"></a> [traefik](#module\_traefik) | github.com/canonical/traefik-k8s-operator//terraform | main |

## Resources

| Name | Type |
|------|------|
| [juju_application.openfga](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_integration.openfga_db](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_integration.traefik_certs](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_model.core](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/model) | resource |
| [juju_model.iam](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/model) | resource |
| [juju_offer.ingress_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.openfga_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.postgresql_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.send_ca_certificate_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.traefik_route_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_ui"></a> [admin\_ui](#input\_admin\_ui) | The configurations of the Identity Platform Admin UI application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/edge")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | The configurations of the self-signed-certificates application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_enable_admin_ui"></a> [enable\_admin\_ui](#input\_enable\_admin\_ui) | Whether to deploy Admin UI | `bool` | `false` | no |
| <a name="input_enable_kratos_external_idp_integrator"></a> [enable\_kratos\_external\_idp\_integrator](#input\_enable\_kratos\_external\_idp\_integrator) | Whether to deploy Kratos External IdP Integrator | `bool` | `false` | no |
| <a name="input_hydra"></a> [hydra](#input\_hydra) | The configurations of the Hydra application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>    trust   = optional(string, true)<br/>    config  = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_idp_provider_config"></a> [idp\_provider\_config](#input\_idp\_provider\_config) | The external IdP configurations. | <pre>object({<br/>    client_id : string<br/>    issuer_url : optional(string)<br/>    provider : string<br/>    provider_id : string<br/>    scope : optional(string, "profile email address phone")<br/>    microsoft_tenant_id : optional(string)<br/>    apple_team_id : optional(string)<br/>    apple_private_key_id : optional(string)<br/>  })</pre> | <pre>{<br/>  "client_id": "client_id",<br/>  "provider": "generic",<br/>  "provider_id": "provider_id"<br/>}</pre> | no |
| <a name="input_idp_provider_credentials"></a> [idp\_provider\_credentials](#input\_idp\_provider\_credentials) | The external IdP credentials. | <pre>object({<br/>    client_secret : string<br/>    apple_private_key : optional(string)<br/>  })</pre> | <pre>{<br/>  "client_secret": "client_secret"<br/>}</pre> | no |
| <a name="input_kratos"></a> [kratos](#input\_kratos) | The configurations of the Kratos application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>    trust   = optional(string, true)<br/>    config  = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_login_ui"></a> [login\_ui](#input\_login\_ui) | The configurations of the Identity Platform Login UI application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_openfga"></a> [openfga](#input\_openfga) | The configurations of the OpenFGA application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/edge")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_postgresql"></a> [postgresql](#input\_postgresql) | The configurations of the PostgreSQL application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "14/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_traefik"></a> [traefik](#input\_traefik) | The configurations of the Traefik application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@20.04")<br/>  })</pre> | `{}` | no |

## Outputs

No outputs.
