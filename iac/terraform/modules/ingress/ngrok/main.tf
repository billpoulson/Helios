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

resource "helm_release" "ngrok-ingress-controller" {
  namespace  = var.app_namespace
  name       = "ngrok-ingress-controller"
  repository = "https://ngrok.github.io/kubernetes-ingress-controller"
  chart      = "kubernetes-ingress-controller"

  set {
    name  = "credentials.apiKey"
    value = var.ngrok_api_key
  }

  set {
    name  = "credentials.authtoken"
    value = var.ngrok_authtoken
  }
}
