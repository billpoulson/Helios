resource "kubernetes_ingress_v1" "module_ingress" {

  metadata {
    name      = "${var.app_name}-ingress"
    namespace = var.app_namespace
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = [
        "www.exhelion.net",
        "api.exhelion.net"
      ]
      secret_name = "exhelion-net-tls"
    }

    rule {
      host = "www.exhelion.net"
      http {

        path {
          path      = var.path
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.service_template.metadata[0].name
              port {
                number = var.container_port
              }
            }
          }
        }
      }
    }
  }
}


# resource "kubernetes_ingress_v1" "ingress" {
#   metadata {
#     name      = "${var.app_name}-ingress"
#     namespace = var.namespace
#     annotations = {
#       "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
#     }
#   }
#   spec {
#     ingress_class_name = "nginx"
#     tls {
#       hosts       = [var.domain]
#       secret_name = "${var.domain}-tls"
#     }
#     rule {
#       host = var.domain
#       http {
#         path {
#           path      = var.sub_path
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.service.metadata[0].name
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }
