variable "model" {
  description = "The name of the Juju model to deploy to."
  type        = string
  default     = "identity-platform"
}

variable "deploy_admin_ui" {
  type        = bool
  default     = false
  description = "Whether to deploy Admin UI"
}

variable "deploy_kratos_external_idp_integrator" {
  type        = bool
  default     = false
  description = "Whether to deploy Kratos External IdP Integrator"
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

variable "openfga_offer_url" {
  description = "OpenFGA Offer URL"
  type        = string
  default     = "admin/core.openfga"
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

variable "send_ca_certificate_offer_url" {
  description = "Send CA Certificate Offer URL"
  type        = string
  default     = "admin/core.send-ca-cert"
}
