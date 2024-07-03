
provider "kafka" {
  bootstrap_servers = [
    "my-kafka-controller-0.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092",
    "my-kafka-controller-1.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092",
    "my-kafka-controller-2.my-kafka-controller-headless.kafka-dev.svc.cluster.local:9092",
  ]

  # sasl_username = "user1"
  # sasl_password = "boMGjEa3iL"
}

resource "kafka_topic" "simple-topic" {
  name               = "simple-topic"
  replication_factor = 3
  partitions         = 3
  config = {
    "cleanup.policy" = "compact"
  }
}

# resource "kafka_topic" "test_topic_x" {
#   name               = "test-topic-x"
#   replication_factor = 3
#   partitions         = 3
#   config = {
#     "cleanup.policy" = "compact"
#   }
# }

# resource "kafka_topic" "test_topic" {
#   name               = "test-topic"
#   replication_factor = 3
#   partitions         = 3
#   config = {
#     "cleanup.policy" = "compact"
#   }
# }

# resource "kafka_topic" "example_topic" {
#   name               = "example-topic"
#   replication_factor = 3
#   partitions         = 3
#   config = {
#     "cleanup.policy" = "compact"
#   }
# }

# resource "kafka_topic" "another_topic" {
#   name               = "another-topic"
#   replication_factor = 3
#   partitions         = 3
#   config = {
#     "cleanup.policy" = "delete",
#     "retention.ms"   = "604800000" # 7 days
#   }
# }
