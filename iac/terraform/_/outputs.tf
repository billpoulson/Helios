
# output "sql_sa_password" {
#   value     = local.postgres_password
#   sensitive = true
# }

# # output "postgres_internal_service" {
# #   description = "The internal service hostname for the postgres"
# #   value       = local.postgres_hostname
# # }

# # output "strapi_app_keys" {
# #   value     = local.strapi_app_keys
# #   sensitive = true
# # }

# # output "strapi_api_token_salt" {
# #   value     = randombyte_bytes.strapi_api_token_salt.result_base64
# #   sensitive = true
# # }

# # output "strapi_admin_jwt_secret" {
# #   value     = randombyte_bytes.strapi_admin_jwt_secret.result_base64
# #   sensitive = true
# # }

# # output "strapi_transfer_token_salt" {
# #   value     = randombyte_bytes.strapi_transfer_token_salt.result_base64
# #   sensitive = true
# # }

# # output "strapi_jwt_secret" {
# #   value     = randombyte_bytes.strapi_jwt_secret.result_base64
# #   sensitive = true
# # }

# output "porta_oauth_image_name" {
#   value = module.docker_images.porta_oauth_image_name
# }
# output "app_namespace" {
#   value = kubernetes_namespace_v1.sample_app.metadata[0].name
# }
