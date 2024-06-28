variable "namespace" {
  type = string
}

variable "ingresses" {
  description = "A list of ingress rules."
  type = list(object({
    name         = string
    service_name = string
    service_port = number
    host         = string
    path         = string
  }))
}


variable "maint_route" {
  description = "maint site config"
  type = object({
    enable_maintenance = bool
    service_name = string
    service_port = number
  })
}
