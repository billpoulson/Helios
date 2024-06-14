
resource "kubernetes_namespace_v1" "environment_namespace" {
  metadata {
    name = var.env_namespace
  }
}
