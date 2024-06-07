variable "app_namespace" {
  description = "app_namespace"
  type        = string
}

variable "kubernetes_config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}
