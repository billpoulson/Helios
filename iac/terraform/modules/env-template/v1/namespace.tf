
resource "kubernetes_namespace_v1" "environment_namespace" {

  metadata {
    name = var.namespace
    labels = {
    }
    annotations = {
      "linkerd.io/inject" = "enabled"
      # "linkerd.io/proxy-control-plane-namespace" = "linkerd"
    }
  }
}
