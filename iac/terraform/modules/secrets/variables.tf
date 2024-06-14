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

output "sql_sa_password" {
  value     = random_password.sql_sa_password.result
  sensitive = true
}
