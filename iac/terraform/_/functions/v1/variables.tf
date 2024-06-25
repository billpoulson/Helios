variable "env" {
  type        = string
  description = "The environment name"
}

variable "app_namespace" {
  description = "app_namespace"
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

variable "function_a_image_name" {
  description = "image name"
  type        = string
}
variable "deno_image_name" {
  description = "deno image name"
  type        = string
}


variable "pv_claim_name" {
  description = "persistent volume claim to use"
  type        = string
}


