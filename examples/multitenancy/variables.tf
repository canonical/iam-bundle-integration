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

variable "traefik" {
  description = "The configurations of the Traefik application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "latest/stable")
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

variable "openfga" {
  description = "The configurations of the openfga application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "latest/edge")
    config  = optional(map(string), {})
  })
  default = {}
}

variable "hydra" {
  description = "The configurations of the Hydra application."
  type = object({
    name        = optional(string, "hydra")
    units       = optional(number, 1)
    channel     = optional(string, "latest/edge")
    base        = optional(string, "ubuntu@22.04")
    trust       = optional(bool, true)
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
    channel     = optional(string, "latest/edge")
    base        = optional(string, "ubuntu@22.04")
    trust       = optional(bool, true)
    config      = optional(map(string), {})
    constraints = optional(string, "")
    revision    = optional(number, null)
    resources   = optional(map(string), {})
  })
  default = {}
}

variable "login_ui" {
  description = "The configurations of the Login UI application."
  type = object({
    name        = optional(string, "login-ui")
    units       = optional(number, 1)
    channel     = optional(string, "latest/edge")
    base        = optional(string, "ubuntu@22.04")
    trust       = optional(bool, true)
    config      = optional(map(string), {})
    constraints = optional(string, "")
    revision    = optional(number, null)
    resources   = optional(map(string), {})
  })
  default = {}
}

variable "tenant_service" {
  description = "The configurations of the tenant-service application."
  type = object({
    name      = optional(string, "tenant-service")
    units     = optional(number, 1)
    channel   = optional(string, "latest/edge")
    base      = optional(string, "ubuntu@22.04")
    config    = optional(map(string), {})
    revision  = optional(number, null)
    resources = optional(map(string), {})
  })
  default = {}
}

variable "hook_service" {
  description = "The configurations of the hook-service application."
  type = object({
    name      = optional(string, "hook-service")
    units     = optional(number, 1)
    channel   = optional(string, "latest/edge")
    base      = optional(string, "ubuntu@22.04")
    config    = optional(map(string), {})
    revision  = optional(number, null)
    resources = optional(map(string), {})
  })
  default = {}
}

variable "enable_kratos_external_idp_integrator" {
  type        = bool
  default     = false
  description = "Whether to deploy Kratos External IdP Integrator"
}

variable "kratos_external_idp_integrator" {
  description = "The configurations of the Kratos External IdP Integrator application."
  type = object({
    name    = optional(string, "kratos-external-idp-integrator")
    units   = optional(number, 1)
    channel = optional(string, "latest/edge")
    base    = optional(string, "ubuntu@22.04")
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
    }))
    constraints = optional(string, "")
    revision    = optional(number, null)
  })
  default = {}
}
