
resource "kubernetes_secret_v1" "strapi_secrets" {
  metadata {
    namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
    name      = "strapi-secrets"
  }
  type = "Opaque"

  data = {
    app_keys            = local.strapi_app_keys
    api_token_salt      = randombyte_bytes.strapi_api_token_salt.result_base64
    admin_jwt_secret    = randombyte_bytes.strapi_admin_jwt_secret.result_base64
    transfer_token_salt = randombyte_bytes.strapi_transfer_token_salt.result_base64
    jwt_secret          = randombyte_bytes.strapi_jwt_secret.result_base64
    strapi_root_token   = base64encode("[DEV-TOKEN-PLACEHOLDER]")
  }
}

resource "kubernetes_secret_v1" "postgres_secrets" {
  metadata {
    namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
    name      = "postgres-secrets"
  }
  type = "Opaque"

  data = {
    password = random_password.sql_sa_password.result
  }
}
