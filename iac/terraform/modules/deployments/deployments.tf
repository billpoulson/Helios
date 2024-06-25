resource "kubernetes_deployment_v1" "deployment" {

  metadata {
    namespace = var.namespace
    name      = var.name
  }

  spec {
    replicas = 1
    strategy {
      type = "RollingUpdate"
    }
    selector {
      match_labels = {
        app = var.name
      }
    }

    template {

      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          name              = var.name
          image             = var.image
          image_pull_policy = var.image_pull_policy

          port {
            container_port = var.container_port
          }

          env {
            name = "DOTENV_KEY"
            value_from {
              secret_key_ref {
                name = var.dot_env_secret
                key  = var.dot_env_key
              }
            }
          }

          volume_mount {
            name       = "shared-data"
            mount_path = "/app/data"
          }
        }

        volume {
          name = "shared-data"
          persistent_volume_claim {
            claim_name = var.default_volume_pvc_name
          }
        }
      }
    }
  }
}
