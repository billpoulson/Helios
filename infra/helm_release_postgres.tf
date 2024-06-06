
# resource "helm_release" "postgres" {
#   namespace = kubernetes_namespace_v1.sample_app.metadata[0].name

#   name       = "postgres-1"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "postgresql"
#   version    = "14.3.0"

#   set {
#     name  = "global.postgresql.auth.postgresPassword"
#     value = local.strapi_postgres_user_password
#   }
# }
