
module "porta-oauthx-v1-build-hash" {
  source = "../docker-images/vx"
  docker_context="../../apps/v1/api/oauth-service"
  helios_workspace = var.helios_workspace
}

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
    context_hash = module.porta-oauthx-v1-build-hash.value

  }

}
