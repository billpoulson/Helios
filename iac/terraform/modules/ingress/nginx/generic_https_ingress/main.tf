resource "kubernetes_ingress_v1" "ingress" {

  for_each = { for ingress in var.ingresses : ingress.name => ingress }

  metadata {
    name      = each.value.name
    namespace = each.value.namespace
    annotations = {
      "cert-manager.io/cluster-issuer"                 = var.cluster_issuer
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "false"
      "nginx.ingress.kubernetes.io/hsts"               = "false"
    }
  }

  spec {
    ingress_class_name = "nginx"

    dynamic "tls" {
      for_each = each.value.tls

      content {
        hosts       = tls.value.hosts
        secret_name = tls.value.secret_name
      }
    }

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
