
resource "kubernetes_namespace_v1" "environment_namespace" {

  metadata {
    name = var.namespace
    labels = {
      "linkerd.io/inject" = "enabled"
    }
  }
}
