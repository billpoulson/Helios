resource "kubernetes_ingress_v1" "smoke-test-function-deno" {
  metadata {
    namespace = var.app_namespace
    name      = "smoke-test-function-http-ingress-deno"
  }

  spec {
    ingress_class_name = "ngrok"
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/v1/functions/smoke-test-deno"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.function_a_deno.metadata[0].name
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

# Service
resource "kubernetes_service_v1" "function_a_deno" {
  metadata {
    namespace = var.app_namespace
    name      = "function-a-deno"
  }
  spec {
    port {
      port        = 80
      target_port = 8080
    }
    selector = {
      app = "function-a-deno"
    }
  }
}

# Deployment
resource "kubernetes_deployment_v1" "function_a_deno" {
  metadata {
    namespace = var.app_namespace
    name      = "function-a-deno"
  }

  spec {
    replicas = 1
    strategy {
      type = "RollingUpdate"
    }
    selector {
      match_labels = {
        app = "function-a-deno"
      }
    }

    template {
      metadata {
        labels = {
          app = "function-a-deno"
        }
      }

      spec {
        container {
          name              = "function-a-deno"
          image             = var.deno_image_name
          image_pull_policy = "Never"
          port {
            container_port = 8080
          }
          env {
            name  = "PORT"
            value = "8080"
          }

        }
      }
    }
  }
}
