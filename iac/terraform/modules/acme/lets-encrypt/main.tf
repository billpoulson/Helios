terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    # acme = {
    #   source  = "vancluever/acme"
    #   version = "~> 2.0"
    # }
  }
}

resource "kubernetes_manifest" "example" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "name"      = "exhelion-net"
      "namespace" = var.app_namespace
    }
    "spec" = {
      "secretName" = "exhelion-net-tls"
      "issuerRef" = {
        "name" = "letsencrypt-prod"
        # "name" = "letsencrypt-stg"
        "kind" = "ClusterIssuer"
      }
      "commonName" = "exhelion.net"
      "dnsNames"   = ["www.exhelion.net"]
    }
  }
}

resource "kubernetes_manifest" "letsencrypt_clusterissuer" {
  manifest = yamldecode(file("${path.module}/letsencrypt-clusterissuer.yml"))
}
