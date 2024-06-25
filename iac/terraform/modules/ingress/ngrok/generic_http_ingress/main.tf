resource "kubernetes_ingress_v1" "ingress" {
  for_each = { for ingress in var.ingresses : ingress.name => ingress }

  metadata {
    name      = each.value.name
    namespace = each.value.namespace
  }

  spec {
    ingress_class_name = "ngrok"

    rule {
      host = each.value.host
      http {
        path {
          path      = each.value.path
          path_type = "Prefix"
          backend {
            service {
              name = each.value.service_name
              port {
                number = each.value.service_port
              }
            }
          }
        }
      }
    }
  }
}
