# Terraform Module Specifications

This documentation shows the detailed specifications of the Identity Platform
Juju bundle Terraform module.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_juju"></a> [juju](#provider\_juju) | 0.15.1 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_juju"></a> [juju](#requirement\_juju) | >= 0.15.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_model"></a> [model](#input\_model) | The name of the Juju model to deploy to. | `string` | `"identity-platform"` | no |
| <a name="input_core_model"></a> [core\_model](#input\_core\_model) | The name of the Juju model to deploy dependencies to. | `string` | `"core"` | no |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | The configurations of the self-signed-certificates application. | <pre>object({<br>    units   = optional(number, 1)<br>    trust   = optional(bool, true)<br>    config  = optional(map(string), {})<br>    channel = optional(string, "latest/stable")<br>    base    = optional(string, "ubuntu@22.04")<br>  })</pre> | `{}` | no |
| <a name="input_traefik"></a> [traefik](#input\_traefik) | The configurations of the Traefik application. | <pre>object({<br>    units   = optional(number, 1)<br>    trust   = optional(bool, true)<br>    config  = optional(map(string), {})<br>    channel = optional(string, "latest/stable")<br>    base    = optional(string, "ubuntu@20.04")<br>  })</pre> | `{}` | no |
| <a name="input_postgresql"></a> [postgresql](#input\_postgresql) | The configurations of the PostgreSQL application. | <pre>object({<br>    units   = optional(number, 1)<br>    trust   = optional(bool, true)<br>    config  = optional(map(string), {})<br>    channel = optional(string, "14/stable")<br>    base    = optional(string, "ubuntu@22.04")<br>  })</pre> | `{}` | no |
| <a name="input_openfga"></a> [openfga](#input\_openfga) | The configurations of the OpenFGA application. | <pre>object({<br>    units   = optional(number, 1)<br>    trust   = optional(bool, true)<br>    config  = optional(map(string), {})<br>    channel = optional(string, "latest/stable")<br>    base    = optional(string, "ubuntu@22.04")<br>  })</pre> | `{}` | no |
| <a name="input_hydra"></a> [hydra](#input\_hydra) | The configurations of the Hydra application. | <pre>object({<br>    units   = optional(number, 1)<br>    channel = optional(string, "latest/edge")<br>    base    = optional(string, "ubuntu@22.04")<br>    trust   = optional(string, true)<br>    config  = optional(map(string), {})<br>  })</pre> | `{}` | no |
| <a name="input_kratos"></a> [kratos](#input\_kratos) | The configurations of the Kratos application. | <pre>object({<br>    units   = optional(number, 1)<br>    channel = optional(string, "latest/edge")<br>    base    = optional(string, "ubuntu@22.04")<br>    trust   = optional(string, true)<br>    config  = optional(map(string), {})<br>  })</pre> | `{}` | no |
| <a name="input_login_ui"></a> [login\_ui](#input\_login\_ui) | The configurations of the Identity Platform Login UI application. | <pre>object({<br>    units   = optional(number, 1)<br>    trust   = optional(bool, true)<br>    config  = optional(map(string), {})<br>    channel = optional(string, "latest/edge")<br>    base    = optional(string, "ubuntu@22.04")<br>  })</pre> | `{}` | no |
| <a name="input_admin_ui"></a> [admin\_ui](#input\_admin\_ui) | The configurations of the Identity Platform Admin UI application. | <pre>object({<br>    units   = optional(number, 1)<br>    trust   = optional(bool, true)<br>    config  = optional(map(string), {})<br>    channel = optional(string, "latest/edge")<br>    base    = optional(string, "ubuntu@22.04")<br>  })</pre> | `{}` | no |
| <a name="input_idp_provider_config"></a> [idp\_provider\_config](#input\_idp\_provider\_config) | The external Idp provider configurations. | <pre>object({<br>    client_id : string<br>    issuer_url : optional(string)<br>    provider : string<br>    provider_id : string<br>    scope : optional(string, "profile email address phone")<br>    microsoft_tenant_id : optional(string)<br>    apple_team_id : optional(string)<br>    apple_private_key_id : optional(string)<br>  })</pre> | <pre>{<br>  "client_id": "client_id",<br>  "provider": "generic",<br>  "provider_id": "provider_id"<br>}</pre> | no |
| <a name="input_idp_provider_credentials"></a> [idp\_provider\_credentials](#input\_idp\_provider\_credentials) | The external Idp provider credentials. | <pre>object({<br>    client_secret : string<br>    apple_private_key : optional(string)<br>  })</pre> | <pre>{<br>  "client_secret": "client_secret"<br>}</pre> | no |
| <a name="input_ingress_offer_url"></a> [ingress\_offer\_url](#input\_ingress\_offer\_url) | Ingress Offer URL | `string` | `"admin/core.ingress"` | no |
| <a name="input_postgresql_offer_url"></a> [postgresql\_offer\_url](#input\_postgresql\_offer\_url) | PostgreSQL Offer URL | `string` | `"admin/core.postgresql"` | no |
| <a name="input_openfga_offer_url"></a> [openfga\_offer\_url](#input\_openfga\_offer\_url) | OpenFGA Offer URL | `string` | `"admin/core.openfga"` | no |
| <a name="input_send_ca_certificate_offer_url"></a> [send\_ca\_certificate\_offer\_url](#input\_send\_ca\_certificate\_offer\_url) | Send CA Certificate Offer URL | `string` | `"admin/core.send-ca-cert"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oauth_offer_url"></a> [oauth\_offer\_url](#output\_oauth\_offer\_url) | n/a |
| <a name="output_kratos_info_offer_url"></a> [kratos\_info\_offer\_url](#output\_kratos\_info\_offer\_url) | n/a |
<!-- END_TF_DOCS -->
