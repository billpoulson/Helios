
resource "helm_release" "postgres" {
  namespace  = var.app_namespace
  name       = var.instance_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "14.3.0"

  set {
    name  = "global.postgresql.auth.postgresPassword"
    value = var.postgres_password
  }
}

output "postgres_hostname" {
  value = "${helm_release.postgres.metadata[0].name}.${helm_release.postgres.metadata[0].namespace}.svc.cluster.local"
}
