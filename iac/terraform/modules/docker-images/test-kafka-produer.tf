
module "v1-mq-kafka-test-producer-build-hash" {
  source = "../docker-images/vx"
  docker_context="../../apps/v1/mq/kafka/test-producer"
  helios_workspace = var.helios_workspace
}

resource "docker_image" "v1-mq-kafka-test-producer" {

  name         = "v1-mq-kafka-test-producer"
  keep_locally = true

  build {
    context = "../../apps/v1/mq/kafka/test-producer"
    tag     = ["latest"]
  }

  triggers = {
    context_hash = module.v1-mq-kafka-test-consumer-build-hash.value
  }
}
