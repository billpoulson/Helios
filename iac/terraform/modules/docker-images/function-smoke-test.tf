
module "v1-functions-smoke-test-build-hash" {
  source = "../docker-images/vx"
  docker_context="../../apps/v1/functions/smoke-test"
  helios_workspace = var.helios_workspace
}

resource "docker_image" "v1-functions-smoke-test" {

  name         = "v1-functions-smoke-test"
  keep_locally = true

  build {
    context = "../../apps/v1/functions/smoke-test"
    tag     = ["latest"]
  }

  triggers = {
    context_hash = module.v1-functions-smoke-test-build-hash.value

  }

}
