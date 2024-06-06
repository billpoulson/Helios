
locals {
  env                           = var.env
  strapi_postgres_user_password = random_password.sql_sa_password.result
  strapi_postgres_database      = "application_db"
  strapi_app_keys               = join(",", [for i in range(4) : randombyte_bytes.strapi_app_keys[i].result_base64])
  # postgres_hostname             = "${helm_release.postgres.metadata[0].name}.${helm_release.postgres.metadata[0].namespace}.svc.cluster.local"
}
