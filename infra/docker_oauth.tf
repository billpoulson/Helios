
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
          path      = "/"
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
      target_port = 8000
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
          name              = "simple-oauth"
          image             = "porta-oauthx:latest"
          image_pull_policy = "Never"
          port {
            container_port = 8000
          }
          env {
            name  = "PORT"
            value = "8000"
          }
        }
      }
    }
  }
}
