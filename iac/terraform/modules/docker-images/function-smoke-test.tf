resource "docker_image" "v1-functions-smoke-test" {

  name         = "v1-functions-smoke-test"
  keep_locally = true

  build {
    context = "../../functions/v1/smoke-test"
    tag     = ["latest"]
  }

  triggers = {
    context_hash = local.timestamp
  }

}
