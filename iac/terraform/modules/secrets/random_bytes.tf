
# resource "randombyte_bytes" "strapi_app_keys" {
#   count  = 4
#   length = 16
# }

# resource "randombyte_bytes" "strapi_api_token_salt" {
#   length = 16
# }

# resource "randombyte_bytes" "strapi_admin_jwt_secret" {
#   length = 16
# }

# resource "randombyte_bytes" "strapi_transfer_token_salt" {
#   length = 16
# }

# resource "randombyte_bytes" "strapi_jwt_secret" {
#   length = 16
# }

resource "random_password" "sql_sa_password" {
  length           = 64
  special          = true
  override_special = "_%@"
}
