terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Output the full image ID and tag for verification
output "porta_oauth_image_id" {
  value = docker_image.porta-oauthx.image_id
}

output "porta_oauth_image_name" {
  value = docker_image.porta-oauthx.name
}
