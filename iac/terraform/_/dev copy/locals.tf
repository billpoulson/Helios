locals {
  env           = var.env
  env_namespace = kubernetes_namespace_v1.environment_namespace.metadata.0.name
}
