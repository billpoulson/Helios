variable "env" {
  type        = string
  description = "The environment name"
}


variable "kube_config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context_name" {
  description = "Kubernetes config context to use"
  type        = string
  # default     = "docker-desktop-dev"
}


variable "docker_image_version" {
  description = "Version of the Docker image"
  type        = string
  default     = "latest"
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

variable "app_namespace" {
  description = "app_namespace"
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


variable "letsencrypt_acmed_server_url_prod" {
  default = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "letsencrypt_acme_server_url_stage" {
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}
