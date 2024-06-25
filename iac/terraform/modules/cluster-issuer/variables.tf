variable "name" {
  description = "cluster issuer name"
  type        = string
}

variable "acme_email_contact" {
  description = "primary email contact for acme generated certificates"
  type        = string
}

variable "acme_server_url" {
  description = "primary email contact for acme generated certificates"
  type        = string
}

output "name" {
  value = var.name
}
