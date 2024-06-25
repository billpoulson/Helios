output "library" {
  value = {
    api = {
      porta-oauthx-v1 = docker_image.porta-oauthx-v1.name
    }
    functions = {
      v1-smoke-test      = docker_image.v1-functions-smoke-test.name
      v1-smoke-test-deno = docker_image.v1-functions-smoke-test-deno.name
    }
    apps = {
      porta-oauthx-v1 = docker_image.porta-oauthx-v1.name
    }
  }
}
