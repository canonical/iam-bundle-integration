variable "model" {
  description = "The name of the Juju model to deploy to."
  type        = string
  default     = "identity-platform"
}

variable "core_model" {
  description = "The name of the Juju model to deploy dependencies to."
  type        = string
  default     = "core"
}

variable "certificates" {
  description = "The configurations of the self-signed-certificates application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "latest/stable")
    base    = optional(string, "ubuntu@22.04")
  })
  default = {}
}

variable "traefik" {
  description = "The configurations of the Traefik application."
  type = object({
    units   = optional(number, 1)
    trust   = optional(bool, true)
    config  = optional(map(string), {})
    channel = optional(string, "latest/stable")
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
    channel = optional(string, "14/stable")
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
    channel = optional(string, "latest/stable")
    base    = optional(string, "ubuntu@22.04")
  })
  default = {}
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

variable "ingress_offer_url" {
  description = "Ingress Offer URL"
  type        = string
  default     = "admin/core.ingress"
}

variable "postgresql_offer_url" {
  description = "PostgreSQL Offer URL"
  type        = string
  default     = "admin/core.postgresql"
}

variable "openfga_offer_url" {
  description = "OpenFGA Offer URL"
  type        = string
  default     = "admin/core.openfga"
}

variable "send_ca_certificate_offer_url" {
  description = "Send CA Certificate Offer URL"
  type        = string
  default     = "admin/core.send-ca-cert"
}
