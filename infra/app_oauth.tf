

# Deployment
resource "kubernetes_deployment_v1" "simple_oauth" {
  metadata {
    namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
    name      = "simple-oauth"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "simple-oauth"
      }
    }

    template {
      metadata {
        labels = {
          app = "simple-oauth"
        }
      }

      spec {
        container {
          name              = "simple-oauth"
          image             = module.docker_module.porta_oauth_image_name
          image_pull_policy = "Never"
          port {
            container_port = 8000
          }
          env {
            name  = "PORT"
            value = "8000"
          }
          volume_mount {
            name       = "example-data"
            mount_path = "/app/data"
          }
        }

        volume {
          name = "example-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.data_volumec.metadata[0].name
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service_v1" "simple_oauth" {
  metadata {
    namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
    name      = "simple-oauth"
  }

  spec {
    port {
      port        = 80
      target_port = 8000
    }
    selector = {
      app = "simple-oauth"
    }
  }
}

# Ingress
resource "kubernetes_ingress_v1" "simple_oauth" {
  metadata {
    namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
    name      = "simple-oauth"
  }

  spec {
    ingress_class_name = "ngrok"
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.simple_oauth.metadata[0].name
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
