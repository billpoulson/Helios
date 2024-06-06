resource "docker_image" "porta-oauthx" {
  name = "porta-oauthx:latest"
  build {
    context = "../"
  }
}
