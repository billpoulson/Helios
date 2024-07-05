
provider "kafka" {
  bootstrap_servers = [
    "127.0.0.1:9092",
  ]
  sasl_username   = "user1"
  sasl_password   = "boMGjEa3iL"
  sasl_mechanism    = "scram-sha256"  # Example mechanism, replace if necessary
  # sasl_username   = "controller_user"
  # sasl_password   = "sP3RTHDsI0"
  skip_tls_verify = true
}

resource "kafka_topic" "test-topic" {
  name               = "test-topic"
  replication_factor = 1
  partitions         = 1
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
