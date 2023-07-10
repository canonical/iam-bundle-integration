variable "model" {
  description = "The name of the Juju model."
  type        = string
  default     = "iam-bundle"
}

variable "name" {
  description = "The name of the Juju application."
  type        = string
  default     = "external-idp-integrator"
}

variable "units" {
  description = "The desired Juju unit count to deploy."
  type        = number
  default     = 1

  validation {
    condition     = var.units > 0
    error_message = "The unit count must be a positive integer."
  }
}

variable "trust" {
  description = "The status to grant the Juju application full access to the cluster."
  type        = bool
  default     = true
}

variable "charm" {
  description = "The application charm operator information."
  type = object({
    name : string
    channel : string
    series : string
  })
  default = {
    name    = "kratos-external-idp-integrator"
    channel = "edge"
    series  = "jammy"
  }
}

variable "config" {
  description = "The application charm operator configurations."
  type = object({
    client_id : string
    client_secret : string
    issuer_url : optional(string)
    provider : string
    provider_id : string
    scope : optional(string, "profile email address phone")
    microsoft_tenant_id : optional(string)
    apple_team_id : optional(string)
    apple_private_key_id : optional(string)
    apple_private_key : optional(string)
  })
  default = {
    client_id     = "client_id"
    client_secret = "client_secret"
    provider      = "generic"
    provider_id   = "provider_id"
  }
}
