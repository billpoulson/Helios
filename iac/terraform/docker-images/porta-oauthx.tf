
locals {
  timestamp = formatdate("YYYYMMDDHHMMss", timestamp())
}

resource "docker_image" "porta-oauthx" {
  name         = "porta-oauthx"
  keep_locally = false
  build {
    context      = "../../services/oauth-service"
    tag          = ["latest"]
    force_remove = true
    remove       = true
  }
  triggers = {
    context_hash = local.timestamp
  }

}
