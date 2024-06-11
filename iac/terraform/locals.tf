
locals {
  env                      = var.env
  postgres_password        = random_password.sql_sa_password.result
  strapi_postgres_database = "application_db"
  strapi_app_keys          = join(",", [for i in range(4) : randombyte_bytes.strapi_app_keys[i].result_base64])

}
