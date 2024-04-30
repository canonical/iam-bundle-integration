# Terraform Module Specifications

This documentation shows the detailed specifications of the Identity Platform
Juju bundle Terraform module.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_juju"></a> [juju](#provider\_juju) | 0.11.0 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_juju"></a> [juju](#requirement\_juju) | ~> 0.11.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_model"></a> [model](#input\_model) | The name of the Juju model to deploy to. | `string` | `"identity-platform"` | no |
| <a name="input_hydra"></a> [hydra](#input\_hydra) | The configurations of the Hydra application. | <pre>object({<br>    units   = optional(number, 1)<br>    channel = optional(string, "latest/edge")<br>    base    = optional(string, "ubuntu@22.04")<br>    trust   = optional(string, true)<br>    config  = optional(map(string), {})<br>  })</pre> | `{}` | no |
| <a name="input_kratos"></a> [kratos](#input\_kratos) | The configurations of the Kratos application. | <pre>object({<br>    units   = optional(number, 1)<br>    channel = optional(string, "latest/edge")<br>    base    = optional(string, "ubuntu@22.04")<br>    trust   = optional(string, true)<br>    config  = optional(map(string), {})<br>  })</pre> | `{}` | no |
| <a name="input_login_ui"></a> [login\_ui](#input\_login\_ui) | The configurations of the Identity Platform Login UI application. | <pre>object({<br>    units   = optional(number, 1)<br>    trust   = optional(bool, true)<br>    config  = optional(map(string), {})<br>    channel = optional(string, "latest/edge")<br>    base    = optional(string, "ubuntu@22.04")<br>  })</pre> | `{}` | no |
| <a name="input_idp_provider_config"></a> [idp\_provider\_config](#input\_idp\_provider\_config) | The external Idp provider configurations. | <pre>object({<br>    client_id : string<br>    issuer_url : optional(string)<br>    provider : string<br>    provider_id : string<br>    scope : optional(string, "profile email address phone")<br>    microsoft_tenant_id : optional(string)<br>    apple_team_id : optional(string)<br>    apple_private_key_id : optional(string)<br>  })</pre> | <pre>{<br>  "client_id": "client_id",<br>  "provider": "generic",<br>  "provider_id": "provider_id"<br>}</pre> | no |
| <a name="input_idp_provider_credentials"></a> [idp\_provider\_credentials](#input\_idp\_provider\_credentials) | The external Idp provider credentials. | <pre>object({<br>    client_secret : string<br>    apple_private_key : optional(string)<br>  })</pre> | <pre>{<br>  "client_secret": "client_secret"<br>}</pre> | no |
| <a name="input_internal_ingress"></a> [internal\_ingress](#input\_internal\_ingress) | The internal ingress. | <pre>object({<br>    name : string<br>    endpoint : optional(string)<br>  })</pre> | <pre>{<br>  "name": "internal-ingress"<br>}</pre> | no |
| <a name="input_juju_offers"></a> [juju\_offers](#input\_juju\_offers) | The Juju offers provided by other charmed operators. | <pre>object({<br>    external_ingress_offer : optional(string)<br>  })</pre> | `{}` | no |
## Outputs

No outputs.
<!-- END_TF_DOCS -->
