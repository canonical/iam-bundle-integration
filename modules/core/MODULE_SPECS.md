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

No modules.

## Resources

| Name | Type |
|------|------|
| [juju_application.certificates](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_application.postgresql](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_application.traefik](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/application) | resource |
| [juju_integration.traefik_certs](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration) | resource |
| [juju_model.core](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/model) | resource |
| [juju_offer.ingress_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.postgresql_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.send_ca_certificate_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |
| [juju_offer.traefik_route_offer](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/offer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificates"></a> [certificates](#input\_certificates) | The configurations of the self-signed-certificates application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_postgresql"></a> [postgresql](#input\_postgresql) | The configurations of the PostgreSQL application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "14/stable")<br/>    base    = optional(string, "ubuntu@22.04")<br/>  })</pre> | `{}` | no |
| <a name="input_traefik"></a> [traefik](#input\_traefik) | The configurations of the Traefik application. | <pre>object({<br/>    units   = optional(number, 1)<br/>    trust   = optional(bool, true)<br/>    config  = optional(map(string), {})<br/>    channel = optional(string, "latest/stable")<br/>    base    = optional(string, "ubuntu@20.04")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ingress_offer_url"></a> [ingress\_offer\_url](#output\_ingress\_offer\_url) | The Ingress Juju offer resource. |
| <a name="output_postgresql_offer_url"></a> [postgresql\_offer\_url](#output\_postgresql\_offer\_url) | The PostgreSQL Juju offer resource. |
| <a name="output_send_ca_certificate_offer_url"></a> [send\_ca\_certificate\_offer\_url](#output\_send\_ca\_certificate\_offer\_url) | The certificates Juju offer resource. |
| <a name="output_traefik_route_offer_url"></a> [traefik\_route\_offer\_url](#output\_traefik\_route\_offer\_url) | The Traefik route Juju offer resource. |
