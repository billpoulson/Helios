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
          path      = "/OID"
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

resource "kubernetes_service_v1" "simple_oauth" {
  metadata {
    namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
    name      = "simple-oauth"
  }
  spec {
    port {
      port        = 80
      target_port = 80
    }
    selector = {
      app = "simple-oauth"
    }
  }
}

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
          name  = "simple-oauth"
          image = "wickerlabs/maintenance:${var.docker_image_version}"
          port {
            container_port = 80
          }
          env {
            name  = "PORT"
            value = "80"
          }
          env {
            name  = "RESPONSE_CODE"
            value = "200"
          }
          env {
            name  = "THEME"
            value = "Dark"
          }
          env {
            name  = "TITLE"
            value = "Under maintenance"
          }
          env {
            name  = "HEADLINE"
            value = "We'll be right back,"
          }
          env {
            name  = "MESSAGE"
            value = "Sorry for the inconvenience but we're performing some maintenance at the moment. If you need to you can always {{contact}}, otherwise we'll be back online shortly!"
          }
          env {
            name  = "TEAM_NAME"
            value = "Exhelion"
          }
          env {
            name  = "CONTACT_LINK"
            value = "Contact US"
          }
          env {
            name  = "MAIL_ADDRESS"
            value = "me@email.com"
          }
        }
      }
    }
  }
}
