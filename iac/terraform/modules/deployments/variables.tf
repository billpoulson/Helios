variable "namespace" {
  type        = string
  description = "environment namespace"
}

variable "image" {
  description = "docker image name"
  type        = string
}
variable "dot_env_secret" {
  description = "dot_env_project_key"
  type        = string
  default     = "dotenv-keys"
}

variable "dot_env_key" {
  description = "dot_env_project_key"
  type        = string
}

variable "replicas" {
  description = "dot_env_project_key"
  type        = number
  default = 1
}

# variable "dot_env_target_env" {
#   description = "dot env target"
#   type        = string
# }

variable "image_pull_policy" {
  description = "docker image pull policy"
  type        = string
  default     = "IfNotPresent"
}
variable "name" {
  description = "deployment name"
  type        = string
}

variable "enable_maintenance" {
  description = "enable maintenance mode"
  type        = bool
  default     = false
}
variable "default_volume_pvc_name" {
  description = "persistent volume claim for data"
  type        = string
}

variable "container_port" {
  description = "persistent volume claim for data"
  type        = string
}
