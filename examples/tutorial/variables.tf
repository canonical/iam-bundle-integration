variable "enable_admin_ui" {
  type        = bool
  default     = false
  description = "Whether to deploy Admin UI"
}

variable "enable_kratos_external_idp_integrator" {
  type        = bool
  default     = false
  description = "Whether to deploy Kratos External IdP Integrator"
}

variable "kratos_external_idp_integrator" {
  description = "The configurations of the Kratos External IdP Integrator application."
  type = object({
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
    constraints = optional(string, "arch=amd64")
  })
  default = {
    config = {
      client_id            = "client_id"
      client_secret        = "client_secret"
      provider             = "generic"
      provider_id          = "provider_id"
      issuer               = "https://example.issuer.com"
      microsoft_tenant_id  = ""
      apple_team_id        = ""
      apple_private_key_id = ""
      apple_private_key    = ""
    }
  }
  
}
variable "hydra" {
  description = "The configurations of the Hydra application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "latest/stable")
    base    = optional(string, "ubuntu@22.04")
    trust   = optional(string, true)
    config  = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
  })
  default = {}
}

variable "kratos" {
  description = "The configurations of the Kratos application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "latest/stable")
    base    = optional(string, "ubuntu@22.04")
    trust   = optional(string, true)
    config  = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
  })
  default = {}
}

variable "login_ui" {
  description = "The configurations of the Identity Platform Login UI application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "latest/stable")
    base    = optional(string, "ubuntu@22.04")
    constraints = optional(string, "arch=amd64")
  })
  default = {}
}

variable "admin_ui" {
  description = "The configurations of the Identity Platform Admin UI application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "latest/edge")
    base    = optional(string, "ubuntu@22.04")
    constraints = optional(string, "arch=amd64")
  })
  default = {}
}

variable "certificates" {
  description = "The configurations of the self-signed-certificates application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "1/stable")
    base    = optional(string, "ubuntu@24.04")
  })
  default = {}
}

variable "traefik" {
  description = "The configurations of the Traefik application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "latest/edge")
    base    = optional(string, "ubuntu@20.04")
  })
  default = {}
}

variable "postgresql" {
  description = "The configurations of the PostgreSQL application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "14/edge")
    base    = optional(string, "ubuntu@22.04")
  })
  default = {}
}

variable "openfga" {
  description = "The configurations of the OpenFGA application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "latest/edge")
    base    = optional(string, "ubuntu@22.04")
  })
  default = {}
}
