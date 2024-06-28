resource "kubernetes_ingress_v1" "ingress" {
  for_each = { for ingress in var.ingresses : ingress.name => ingress }

  metadata {
    name      = each.value.name
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = each.value.host
      http {
        path {
          path      = each.value.path
          path_type = "Prefix"
          backend {
            service {
              name = var.maint_route.enable_maintenance ? var.maint_route.service_name : each.value.service_name
              port {
                number = var.maint_route.enable_maintenance ? var.maint_route.service_port : each.value.service_port
              }
            }
          }
        }
      }
    }
  }
}