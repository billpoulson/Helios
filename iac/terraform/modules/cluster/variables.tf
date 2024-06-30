
variable "kube_context_name" {
  description = "Kubernetes config context to use"
  type        = string
}

variable "kube_config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}