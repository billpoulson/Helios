locals {
  name    = "simple-oauth"
  ingress = "${local.name}-http-ingress"
  path    = "/api"
}

resource "kubernetes_service_v1" "service" {
  metadata {
    namespace = var.app_namespace
    name      = local.name
  }
  spec {
    port {
      port        = var.expose_port
      target_port = var.container_port
    }
    selector = {
      app = local.name
    }
  }
}

# resource "kubernetes_service_v1" "service" {
#   metadata {
#     namespace = var.app_namespace
#     name      = local.name
#   }
#   spec {
#     port {
#       port        = var.expose_port
#       target_port = var.container_port
#     }
#     selector = {
#       app = local.name
#     }
#   }
# }

resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    namespace = var.app_namespace
    name      = local.ingress
  }
  spec {
    ingress_class_name = "ngrok"
    rule {
      host = var.domain_name
      http {
        path {
          path      = local.path
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.service.metadata[0].name
              port {
                number = kubernetes_service_v1.service.spec[0].port[0].port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment_v1" "simple_oauth" {
  metadata {
    namespace = var.app_namespace
    name      = local.name
  }

  spec {
    replicas = 1
    strategy {
      type = "RollingUpdate"
    }
    selector {
      match_labels = {
        app = local.name
      }
    }

    template {
      metadata {
        labels = {
          app = local.name
        }
      }

      spec {
        container {
          name              = local.name
          image             = var.docker_image
          image_pull_policy = "IfNotPresent"

          port {
            container_port = kubernetes_service_v1.service.spec[0].port[0].target_port
          }
          env {
            name = "DOTENV_KEY"
            value_from {
              secret_key_ref {
                name = "dotenv-keys"
                key  = "oauth-service"
              }
            }
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



