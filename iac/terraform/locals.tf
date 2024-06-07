
locals {
  env                      = var.env
  postgres_password        = random_password.sql_sa_password.result
  strapi_postgres_database = "application_db"
  strapi_app_keys          = join(",", [for i in range(4) : randombyte_bytes.strapi_app_keys[i].result_base64])
  # maint_site_service_name  = kubernetes_service_v1.maint-site.metadata[0].name
  # postgres_hostname             = "${helm_release.postgres.metadata[0].name}.${helm_release.postgres.metadata[0].namespace}.svc.cluster.local"
}
