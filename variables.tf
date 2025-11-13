variable "model" {
  description = "The uuid of the Juju model to deploy to."
  type        = string
  default     = "identity-platform"
}

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

variable "hydra" {
  description = "The configurations of the Hydra application."
  type = object({
    name        = optional(string, "hydra")
    units       = optional(number, 1)
    channel     = optional(string, "latest/edge")
    base        = optional(string, "ubuntu@22.04")
    trust       = optional(string, true)
    config      = optional(map(string), {})
    constraints = optional(string, "")
    revision    = optional(string, null)
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
    trust       = optional(string, true)
    config      = optional(map(string), {})
    constraints = optional(string, "")
    revision    = optional(string, null)
  })
  default = {}
}

variable "kratos_external_idp_integrator" {
  description = "The configurations of the Kratos application."
  type = object({
    name    = optional(string, "kratos-external-idp-integrator")
    units   = optional(number, 1)
    channel = optional(string, "latest/edge")
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
    revision    = optional(string, null)
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
    channel     = optional(string, "latest/edge")
    base        = optional(string, "ubuntu@22.04")
    constraints = optional(string, "")
    revision    = optional(string, null)
  })
  default = {}
}

variable "admin_ui" {
  description = "The configurations of the Identity Platform Admin UI application."
  type = object({
    name        = optional(string, "admin-ui")
    units       = optional(number, 1)
    trust       = optional(bool, true)
    config      = optional(map(string), {})
    channel     = optional(string, "latest/edge")
    base        = optional(string, "ubuntu@22.04")
    constraints = optional(string, "")
    revision    = optional(string, null)
  })
  default = {}
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

variable "metrics_offer_url" {
  description = "Metrics Offer URL"
  type        = string
  default     = null
}

variable "tracing_offer_url" {
  description = "Tracing Offer URL"
  type        = string
  default     = null
}

variable "logging_offer_url" {
  description = "Logging Offer URL"
  type        = string
  default     = null
}
