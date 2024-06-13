resource "kubernetes_deployment_v1" "module_deployment" {
  metadata {
    namespace = var.app_namespace
    name      = "${var.app_name}-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          # name              = "oauth-manager"
          name              = "${var.app_name}-container"
          image             = var.image_name
          image_pull_policy = "Never"
          port {
            container_port = var.container_port
          }
          env {
            name  = "PORT"
            value = var.container_port
          }
          env {
            name  = "BASE_URL"
            value = "/manage"
          }
          env {
            name  = "API_URL"
            value = "/api"
          }
          # volume_mount {
          #   name       = "example-data"
          #   mount_path = "/app/data"
          # }
        }

        # volume {
        #   name = "example-data"
        #   persistent_volume_claim {
        #     claim_name = var.pv_claim_name
        #   }
        # }
      }
    }
  }
}
