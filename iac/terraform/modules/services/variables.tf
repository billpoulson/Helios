variable "env" {
  type        = string
  description = "The environment name"
}
# variable "app_name" {
#   type        = string
#   description = "The app name the service forwards to"
# }
variable "name" {
  type        = string
  description = "The service name"
}

variable "namespace" {
  description = "namespace"
  type        = string
}

variable "maintenance_mode" {
  description = "enable maintenance mode"
  type        = bool
  default     = false
}

variable "expose_port" {
  description = "exposed port for the service (container wrapper)"
  type        = number
}

variable "container_port" {
  description = "port on the container for the service to use"
  type        = number
}
