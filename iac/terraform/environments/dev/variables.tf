variable "env" {
  type        = string
  description = "The environment name"
}
variable "env_namespace" {
  type        = string
  description = "environment namespace"
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

variable "docker_image_version" {
  description = "Version of the Docker image"
  type        = string
  default     = "latest"
}

variable "ngrok_api_key" {
  description = "API key for ngrok"
  type        = string
}

variable "ngrok_authtoken" {
  description = "ngrok auth token"
  type        = string
}

variable "domain_name" {
  description = "ngrok domain name"
  type        = string
}

variable "enable_maintenance" {
  description = "enable maintenance mode"
  type        = bool
  default     = false
}

variable "helios_workspace" {
  description = "helios workspace path"
  type        = string
}

variable "helios_runner" {
  description = "helios runner path"
  type        = string
}
