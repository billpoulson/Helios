variable "app_namespace" {
  description = "app_namespace"
  type        = string
}


variable "app_name" {
  description = "name of the deployed application (selector)"
  type        = string
}

variable "tls_secret_name" {
  description = "tls secret name"
  type        = string
}

variable "domain_name" {
  description = "ngrok domain name"
  type        = string
}
variable "path" {
  description = "path"
  type        = string
}

variable "container_port" {
  description = "host has traffic to this port"
  type        = number
  default     = 8000
}
variable "public_ingress_port" {
  description = "host has traffic to this port"
  type        = number
  default     = 31080
}

variable "image_name" {
  description = "oauth manager image name"
  type        = string
}

variable "image_version" {
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

variable "api_service_name" {
  description = "name of the api service"
  type        = string
}

output "deployment_name" {
  value = kubernetes_deployment_v1.example.metadata[0].name
}

output "deployment_image" {
  value = kubernetes_deployment_v1.example.spec[0].template[0].spec[0].container[0].image
}
