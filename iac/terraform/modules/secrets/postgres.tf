resource "kubernetes_secret_v1" "postgres_secrets" {
  metadata {
    namespace = var.app_namespace
    name      = "postgres-secrets"
  }
  type = "Opaque"

  data = {
    password = random_password.sql_sa_password.result
  }
}
