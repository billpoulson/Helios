variable "env" {
  description = "app environment"
  type        = string
}

variable "namespace" {
  description = "app namespace"
  type        = string
}

variable "common_domain_name" {
  description = "c"
  type        = string
}

variable "cluster_issuer_name" {
  description = " issuer name"
  type        = string
}

variable "email_contact" {
  description = "primary email contact for acme generated certificates"
  type        = string
}

variable "sub_domains" {
  description = "sub domains"
  type        = list(string)
}

output "tls_secret_name" {
  value = local.tls_secret_name
}

output "tls_certificate_name" {
  value = local.tls_certificate_name
}
