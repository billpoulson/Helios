# Service for the simple-oauth22 application
resource "kubernetes_service" "module_service" {
  metadata {
    namespace = var.app_namespace
    name      = "${var.app_name}-service"
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      port        = var.public_ingress_port # 31080
      target_port = 8000
    }
  }
}
