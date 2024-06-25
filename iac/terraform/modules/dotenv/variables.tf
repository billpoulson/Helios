variable "env" {
  description = "environment"
  type        = string
}

variable "namespace" {
  description = "namespace"
  type        = string
}

variable "secret_name" {
  description = "secret name to store keys"
  type        = string
}

variable "helios_workspace" {
  description = "helios workspace path"
  type        = string
}

variable "helios_runner" {
  description = "helios runner path"
  type        = string
}

variable "kube_context" {
  description = "helios runner path"
  type        = string
  # default = {
  #   "dev"  = "docker-desktop-dev"
  #   "prod" = "docker-desktop-prod"
  # }
}
