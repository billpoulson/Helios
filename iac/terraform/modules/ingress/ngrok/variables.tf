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

variable "ngrok_api_key" {
  description = "API key for ngrok"
  type        = string
}

variable "ngrok_authtoken" {
  description = "ngrok auth token"
  type        = string
}
variable "app_namespace" {
  description = "app_namespace"
  type        = string
}
