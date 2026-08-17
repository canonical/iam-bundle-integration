variable "certificates" {
  description = "The configurations of the self-signed-certificates application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "1/stable")
    base    = optional(string, "ubuntu@22.04")
    config  = optional(map(string), {})
  })
  default = {}
}

variable "istio" {
  description = "The configurations of the Istio application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "2/stable")
    config  = optional(map(string), {})
  })
  default = {}
}

variable "istio_ingress" {
  description = "The configurations of the Istio Ingress application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "2/stable")
    config  = optional(map(string), {})
  })
  default = {}
}

variable "postgresql" {
  description = "The configurations of the PostgreSQL application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "14/edge")
    base    = optional(string, "ubuntu@22.04")
    config  = optional(map(string), { profile = "testing" })
  })
  default = {}
}

variable "hydra" {
  description = "The configurations of the Hydra application."
  type = object({
    name        = optional(string, "hydra")
    units       = optional(number, 1)
    channel     = optional(string, "istio/edge")
    base        = optional(string, "ubuntu@22.04")
    trust       = optional(string, true)
    config      = optional(map(string), {})
    constraints = optional(string, "")
    revision    = optional(number, null)
  })
  default = {}
}

variable "kratos" {
  description = "The configurations of the Kratos application."
  type = object({
    name        = optional(string, "kratos")
    units       = optional(number, 1)
    channel     = optional(string, "istio/edge")
    base        = optional(string, "ubuntu@22.04")
    trust       = optional(string, true)
    config      = optional(map(string), {})
    constraints = optional(string, "")
    revision    = optional(number, null)
  })
  default = {}
}

variable "login_ui" {
  description = "The configurations of the Identity Platform Login UI application."
  type = object({
    name        = optional(string, "login-ui")
    units       = optional(number, 1)
    trust       = optional(bool, true)
    config      = optional(map(string), {})
    channel     = optional(string, "istio/edge")
    base        = optional(string, "ubuntu@22.04")
    constraints = optional(string, "")
    revision    = optional(number, null)
  })
  default = {}
}

variable "kratos_external_idp_integrator" {
  description = "The configurations of the Kratos application."
  type = object({
    name    = optional(string, "kratos-external-idp-integrator")
    units   = optional(number, 1)
    channel = optional(string, "latest/stable")
    base    = optional(string, "ubuntu@22.04")
    trust   = optional(string, true)
    config = optional(object({
      client_id : string
      client_secret : string
      issuer_url : optional(string, "")
      provider : string
      provider_id : string
      scope : optional(string, "profile email address phone")
      microsoft_tenant_id : optional(string, "")
      apple_team_id : optional(string, "")
      apple_private_key_id : optional(string, "")
      apple_private_key : optional(string, "")
      })
    )

    constraints = optional(string, "")
    revision    = optional(number, null)
  })
  default = {}
}

variable "enable_kratos_external_idp_integrator" {
  type        = bool
  default     = false
  description = "Whether to deploy Kratos External IdP Integrator"
}
