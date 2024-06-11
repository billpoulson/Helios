resource "kubernetes_deployment_v1" "simple_oauth" {
  metadata {
    namespace = var.app_namespace
    name      = "simple-oauth"
  }

  spec {
    replicas = 1
    strategy {
      type = "RollingUpdate"
    }
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
          image             = var.oauth_api_image_name
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
            value = "/api"
          }
          volume_mount {
            name       = "example-data"
            mount_path = "/app/data"
          }
        }

        volume {
          name = "example-data"
          persistent_volume_claim {
            claim_name = var.pv_claim_name
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "simple_oauth" {
  metadata {
    namespace = var.app_namespace
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
resource "kubernetes_ingress_v1" "simple_oauth" {
  metadata {
    namespace = var.app_namespace
    name      = "simple-oauth-http-ingress"
  }
  spec {
    ingress_class_name = "ngrok"
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/api"
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

