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

resource "kubernetes_manifest" "acme_cluster_issuer" {

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = var.name
    }
    "spec" = {
      "acme" = {
        "server" = var.acme_server_url
        "email"  = var.acme_email_contact
        "privateKeySecretRef" = {
          "name" = var.name
        }
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "nginx"
              }
            }
          }
        ]
      }
    }
  }
}
