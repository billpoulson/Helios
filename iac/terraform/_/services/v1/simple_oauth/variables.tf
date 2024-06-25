variable "env" {
  type        = string
  description = "The environment name"
}

variable "app_namespace" {
  description = "app_namespace"
  type        = string
}

variable "maintenance_mode" {
  description = "enable maintenance mode"
  type        = bool
  default     = false
}

variable "maintenance_backend_service_name" {
  description = "alternate backend to use when in maintenance "
  type        = string
}

variable "domain_name" {
  description = "ngrok domain name"
  type        = string
}

variable "pv_claim_name" {
  description = "persistent volume claim to use"
  type        = string
}

variable "docker_image" {
  description = "docker image name"
  type        = string
}

variable "docker_image_version" {
  description = "Version of the Docker image"
  type        = string
  default     = "latest"
}

variable "expose_port" {
  description = "exposed port for the service (container wrapper)"
  type        = number
}

variable "container_port" {
  description = "port on the container for the service to use"
  type        = number
}
