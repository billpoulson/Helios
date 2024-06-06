resource "docker_image" "porta-oauthx" {
  name = "porta-oauthx"
  # keep_locally = true
  build {
    context = "../"
  }
}
