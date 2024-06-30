terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}

resource "helm_release" "nginx_ingress" {
  namespace        = "nginx-ingress"
  name             = "nginx-ingress"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.0.6"
  values           = [file("./environments/${var.kube_context_name}/nginx-ingress-values.yml")]
}

variable "kube_context_name" {
  description = "Kubernetes config context to use"
  type        = string
}