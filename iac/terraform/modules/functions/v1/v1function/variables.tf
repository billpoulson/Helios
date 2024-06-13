variable "env" {
  type        = string
  description = "The environment name"
}

variable "app_namespace" {
  description = "app_namespace"
  type        = string
}
variable "api_version" {
  description = "api version"
  type        = string
}

variable "domain_name" {
  description = "ngrok domain name"
  type        = string
}

variable "docker_image_version" {
  description = "Version of the Docker image"
  type        = string
  default     = "latest"
}

variable "maintenance_mode" {
  description = "enable maintenance mode"
  type        = bool
  default     = false
}

variable "docker_image_name" {
  description = "image name"
  type        = string
}

variable "edge_function_name" {
  description = "edge function name"
  type        = string
}
