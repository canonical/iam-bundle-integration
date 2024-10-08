variable "model" {
  description = "The name of the Juju model to deploy to."
  type        = string
  default     = "identity-platform"
}

variable "hydra" {
  description = "The configurations of the Hydra application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "latest/edge")
    base    = optional(string, "ubuntu@22.04")
    trust   = optional(string, true)
    config  = optional(map(string), {})
  })
  default = {}
}

variable "kratos" {
  description = "The configurations of the Kratos application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "latest/edge")
    base    = optional(string, "ubuntu@22.04")
    trust   = optional(string, true)
    config  = optional(map(string), {})
  })
  default = {}
}

variable "openfga" {
  description = "The configurations of the OpenFGA application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "2.0/stable")
    base    = optional(string, "ubuntu@22.04")
    trust   = optional(string, true)
    config  = optional(map(string), {})
  })
  default = {}
}

variable "login_ui" {
  description = "The configurations of the Identity Platform Login UI application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "latest/edge")
    base    = optional(string, "ubuntu@22.04")
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
  })
  default = {}
}

variable "idp_provider_config" {
  description = "The external Idp provider configurations."
  type = object({
    client_id : string
    issuer_url : optional(string)
    provider : string
    provider_id : string
    scope : optional(string, "profile email address phone")
    microsoft_tenant_id : optional(string)
    apple_team_id : optional(string)
    apple_private_key_id : optional(string)
  })
  default = {
    client_id   = "client_id"
    provider    = "generic"
    provider_id = "provider_id"
  }
}

variable "idp_provider_credentials" {
  description = "The external Idp provider credentials."
  type = object({
    client_secret : string
    apple_private_key : optional(string)
  })
  default = {
    client_secret = "client_secret"
  }
  sensitive = true
}

variable "external_ingress" {
  description = "The external ingress."
  type = object({
    name : string
    endpoint : optional(string)
  })
  default = {
    name = "external-ingress"
  }
}
