terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "kubernetes_service_v1" "service" {
  metadata {
    namespace = var.namespace
    name      = var.name
  }
  spec {
    port {
      port        = var.expose_port
      target_port = var.container_port
    }
    selector = {
      app = var.name
    }
  }
}




