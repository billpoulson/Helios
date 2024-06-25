variable "env" {
  type        = string
  description = "The environment name"
}

variable "app_namespace" {
  description = "app_namespace"
  type        = string
}

variable "domain_name" {
  description = "ngrok domain name"
  type        = string
}

variable "public_ingress_port" {
  description = "host has traffic to this port"
  type        = number
}

variable "oauth_manager_image_name" {
  description = "oauth manager image name"
  type        = string
}

variable "docker_image_version" {
  description = "Version of the Docker image"
  type        = string
  default     = "latest"
}

variable "maintenance_mode" {
  description = "enable maintenance mode"
  type        = bool
  default     = false
}

variable "pv_claim_name" {
  description = "persistent volume claim to use"
  type        = string
}


# variable "api_service_name" {
#   description = "name of the api service"
#   type        = string
# }
