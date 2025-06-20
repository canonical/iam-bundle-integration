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
