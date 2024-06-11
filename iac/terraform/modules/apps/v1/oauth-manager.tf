resource "kubernetes_ingress_v1" "oauth_manager" {
  metadata {
    namespace = var.app_namespace
    name      = "oauth-manager-http-ingress"
  }

  spec {
    ingress_class_name = "ngrok"
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/manage"
          path_type = "Prefix"
          backend {
            service {
              name = var.maintenance_mode ? kubernetes_service_v1.maint-site.metadata[0].name : kubernetes_service_v1.oauth_manager.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

# Deployment
resource "kubernetes_deployment_v1" "oauth_manager" {
  metadata {
    namespace = var.app_namespace
    name      = "oauth-manager"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "oauth-manager"
      }
    }

    template {
      metadata {
        labels = {
          app = "oauth-manager"
        }
      }

      spec {
        container {
          name              = "oauth-manager"
          image             = var.oauth_manager_image_name
          image_pull_policy = "Never"
          port {
            container_port = 8000
          }
          env {
            name  = "PORT"
            value = "8000"
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

# Service
resource "kubernetes_service_v1" "oauth_manager" {
  metadata {
    namespace = var.app_namespace
    name      = "oauth-manager"
  }
  spec {
    port {
      port        = 80
      target_port = 8000
    }
    selector = {
      app = "oauth-manager"
    }
  }
}
