variable "app_namespace" {
  description = "app_namespace"
  type        = string
}

output "sql_sa_password" {
  value     = random_password.sql_sa_password.result
  sensitive = true
}
