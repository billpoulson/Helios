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
  values           = [file("${path.module}/nginx-ingress-values.yml")]
}

variable "cluster_http_ingress_port" {
  description = "The port that the ingress controller listens on"
  type        = string
}

variable "cluster_https_ingress_port" {
  description = "The port that the ingress controller listens on"
  type        = string
}
