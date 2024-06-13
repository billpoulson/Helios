
locals {
  env                      = var.env
  env_namespace            = "${var.app_namespace}-${var.env}"
  postgres_password        = module.secrets.sql_sa_password
  strapi_postgres_database = "application_db"
  # strapi_app_keys          = join(",", [for i in range(4) : randombyte_bytes.strapi_app_keys[i].result_base64])

}
