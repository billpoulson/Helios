locals {
  function-name    = "${var.edge_function_name}-${var.api_version}-function"
  function-path    = "/${var.api_version}/functions/${var.edge_function_name}"
  function-ingress = "${local.function-name}-${var.api_version}-http-ingress"
}

# Service
resource "kubernetes_service_v1" "edge_function_service" {
  metadata {
    namespace = var.app_namespace
    name      = local.function-name
  }
  spec {
    port {
      port        = 80
      target_port = 8080
    }
    selector = {
      app = local.function-name
    }
  }
}

resource "kubernetes_ingress_v1" "edge-function-ingress" {
  metadata {
    namespace = var.app_namespace
    name      = local.function-ingress
  }

  spec {
    ingress_class_name = "ngrok"
    rule {
      host = var.domain_name
      http {
        path {
          path      = local.function-path
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.edge_function_service.metadata[0].name
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
resource "kubernetes_deployment_v1" "edge-function-deploy" {
  metadata {
    namespace = var.app_namespace
    name      = local.function-name
  }

  spec {
    replicas = 1
    strategy {
      type = "RollingUpdate"
    }
    selector {
      match_labels = {
        app = local.function-name
      }
    }

    template {
      metadata {
        labels = {
          app = local.function-name
        }
      }

      spec {
        container {
          name              = local.function-name
          image             = var.docker_image_name
          image_pull_policy = "IfNotPresent"
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
