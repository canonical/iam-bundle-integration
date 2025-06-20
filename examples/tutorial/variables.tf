variable "hydra" {
  description = "The configurations of the Hydra application."
  type = object({
    units   = optional(number, 1)
    channel = optional(string, "latest/stable")
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
    channel = optional(string, "latest/stable")
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
    channel = optional(string, "latest/stable")
    base    = optional(string, "ubuntu@22.04")
  })
  default = {}
}
