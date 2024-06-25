variable "env" {
  type        = string
  description = "The environment name"
}

variable "app_namespace" {
  description = "app_namespace"
  type        = string
}

variable "kubernetes_config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubernetes_context" {
  description = "Kubernetes config context to use"
  type        = string
}

variable "instance_name" {
  description = "postgres instace name / hostname"
  type        = string
  default     = "postgres"
}

variable "maintenance_mode" {
  description = "enable maintenance mode"
  type        = bool
  default     = false
}
variable "postgres_password" {
  description = "postgres sa password"
  sensitive   = true
  type        = string
}

