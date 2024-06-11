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

variable "kubernetes_config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubernetes_context" {
  description = "Kubernetes config context to use"
  type        = string
  default     = "docker-desktop"
}

variable "maintenance_backend_service_name" {
  description = "alternate backend to use when in maintenance "
  type        = string
}

variable "domain_name" {
  description = "ngrok domain name"
  type        = string
}

variable "oauth_api_image_name" {
  description = "oauth api image name"
  type        = string
}

variable "pv_claim_name" {
  description = "persistent volume claim to use"
  type        = string
}

variable "docker_image_version" {
  description = "Version of the Docker image"
  type        = string
  default     = "latest"
}
