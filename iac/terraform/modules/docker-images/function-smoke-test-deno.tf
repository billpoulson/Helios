

module "v1-functions-smoke-test-deno-build-hash" {
  source = "../docker-images/vx"
  docker_context="../../apps/v1/functions/smoke-test-deno"
  helios_workspace = var.helios_workspace
}

resource "docker_image" "v1-functions-smoke-test-deno" {

  name         = "v1-functions-smoke-test-deno"
  keep_locally = true

  build {
    context = "../../apps/v1/functions/smoke-test-deno"
    tag     = ["latest"]
  }

  triggers = {
    context_hash = local.timestamp
    context_hash = module.v1-functions-smoke-test-deno-build-hash.value

  }

}

