terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

locals {
  timestamp = formatdate("YYYYMMDDHHMMss", timestamp())
}

# Output the full image ID and tag for verification
output "porta_oauth_image_id" {
  value = docker_image.porta-oauthx-v1.image_id
}
output "porta_oauth_image_name" {
  value = docker_image.porta-oauthx-v1.name
}


# Output the full image ID and tag for verification
output "v1_functions_smoke_test_image_name_id" {
  value = docker_image.v1-functions-smoke-test.image_id
}
output "v1_functions_smoke_test_image_name" {
  value = docker_image.v1-functions-smoke-test.name
}
