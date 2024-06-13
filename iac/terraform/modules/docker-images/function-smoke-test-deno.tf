resource "docker_image" "v1-functions-smoke-test-deno" {
  name         = "v1-functions-smoke-test-deno"
  keep_locally = true
  build {
    context = "../../functions/v1/smoke-test-deno"
    tag     = ["latest"]
  }
  triggers = {
    context_hash = local.timestamp
  }
}
