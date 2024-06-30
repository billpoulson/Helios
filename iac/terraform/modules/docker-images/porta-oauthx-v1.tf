resource "docker_image" "porta-oauthx-v1" {
  name         = "porta-oauthx-v1"
  keep_locally = true
  build {
    context = "../../apps/v1/api/oauth-service"
    tag     = ["latest"]
    # force_remove = true
    # remove       = true
  }
  triggers = {
    context_hash = local.timestamp
  }

}
