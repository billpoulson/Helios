variable "env" {
  type        = string
  description = "The environment name"
}

variable "namespace" {
  type        = string
  description = "environment namespace"
}

variable "kube_config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context_name" {
  description = "Kubernetes config context to use"
  type        = string
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

variable "domain_common_name" {
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

variable "primary_email_contact" {
  description = "primary email contact "
  type        = string
}

# variable "cluster_issuer" {
#   description = "cluster certificate issuer"
#   type        = string
# }

variable "dot_env_secret" {
  description = "dot_env_project_key"
  type        = string
  default     = "dotenv-keys"
}

variable "acme_server_url" {
  description = "acme server url"
  type        = string
}

# variable "library" {
#   description = "Library value"
#   type = object({
#     api       = map(string)
#     functions = map(string)
#     apps      = map(string)
#   })
# }
