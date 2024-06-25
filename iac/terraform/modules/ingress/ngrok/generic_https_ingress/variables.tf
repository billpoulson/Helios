variable "cluster_issuer" {
  type = string
  # default = "letsencrypt-prod"
}
variable "ingresses" {
  description = "A list of ingress rules."
  type = list(object({
    name         = string
    namespace    = string
    service_name = string
    service_port = number
    host         = string
    path         = string
    tls = list(object({
      hosts       = list(string)
      secret_name = string
    }))
  }))
}


#            env {
# #             name = "DOTENV_KEY"
# #             value_from {
# #               secret_key_ref {
# #                 name = "postgres-secrets"
# #                 key  = "production"
# #               }
# #             }
# #           }
# #           # volume_mount {
# #           #   name       = "example-data"
# #           #   mount_path = "/app/data"
# #           # }
