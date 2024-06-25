variable "ingresses" {
  description = "A list of ingress rules."
  type = list(object({
    name         = string
    namespace    = string
    service_name = string
    service_port = number
    host         = string
    path         = string
  }))
}


