terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
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
        "kind" = "ClusterIssuer"
      }
      "commonName" = "exhelion.net"
      "dnsNames"   = ["www.exhelion.net"]
    }
  }
}


resource "kubernetes_manifest" "letsencrypt_clusterissuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-prod"
      # "name" = "letsencrypt-stg"
    }
    "spec" = {
      "acme" = {
        # "server" = "https://acme-staging-v02.api.letsencrypt.org/directory"
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "email"  = "poulson.bill@gmail.com" # replace with your email
        "privateKeySecretRef" = {
          "name" = "letsencrypt-prod"
          # "name" = "letsencrypt-stg"
        }
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "nginx" # assuming you're using NGINX Ingress
              }
            }
          }
        ]
      }
    }
  }
}
