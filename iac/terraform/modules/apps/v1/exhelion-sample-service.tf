# Service for the simple-oauth22 application
resource "kubernetes_service" "simple_oauthx6" {
  metadata {
    namespace = var.app_namespace
    name      = "simple-oauth22x6"
  }
  spec {
    selector = {
      app = "oauth-manager"
    }
    port {
      port        = var.public_ingress_port # 31080
      target_port = 8000
    }
  }
}

resource "kubernetes_ingress_v1" "simple_oauth_ingressx6" {

  metadata {
    name      = "simple-oauth22-ingress"
    namespace = var.app_namespace
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts       = ["www.exhelion.net", "api.exhelion.net"]
      secret_name = "exhelion-net-tls"
    }

    rule {
      host = "www.exhelion.net"
      http {

        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.simple_oauthx6.metadata[0].name
              port {
                number = 8000
              }
            }
          }
        }
      }
    }
  }
}





