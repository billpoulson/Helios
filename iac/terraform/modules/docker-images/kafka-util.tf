resource "docker_image" "util-kafka" {

  name         = "util-kafka"
  keep_locally = true

  build {
    context    = "../../docker/kafka-cli-util"
    tag        = ["latest"]
  }

  triggers = {
    context_hash = local.timestamp
  }
}

