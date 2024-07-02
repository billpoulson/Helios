resource "kubernetes_deployment_v1" "kafka" {
  metadata {
    name      = "kafka"
    namespace = var.namespace
    labels = {
      app = "kafka"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "kafka"
      }
    }

    template {
      metadata {
        labels = {
          app = "kafka"
        }
      }

      spec {
        container {
          name  = "kafka"
          image = "wurstmeister/kafka:latest"

          port {
            container_port = 9092
          }
          # env {
          #   name  = "PORT"
          #   value = "9092"
          # }
          env {
            name  = "KAFKA_LISTENERS"
            value = "PLAINTEXT://0.0.0.0:9092"
          }

          env {
            name  = "KAFKA_ZOOKEEPER_CONNECT"
            value = "zookeeper-headless.${var.namespace}.cluster.local:2181"
          }

          env {
            name  = "KAFKA_ADVERTISED_LISTENERS"
            value = "PLAINTEXT://kafka.${var.namespace}.svc.cluster.local:9092"
          }


          env {
            name  = "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR"
            value = "3"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "kafka" {
  metadata {
    name      = "kafka"
    namespace = var.namespace
    labels = {
      app = "kafka"
    }
  }

  spec {
    type = "ClusterIP"
    selector = {
      app = "kafka"
    }

    port {
      port        = 9092
      target_port = 9092
    }
  }
}

# output "kafka_service" {
#   value = "kafka.${var.namespace}.svc.cluster.local:${kubernetes_service_v1.kafka.spec.0.port.0.port}"
# }
