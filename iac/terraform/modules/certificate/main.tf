terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

locals {
  compliant_domain_name_key = replace(var.common_domain_name, ".", "-")
  tls_certificate_name      = "${local.compliant_domain_name_key}-${var.env}-certificate"
  tls_secret_name           = "${local.compliant_domain_name_key}-${var.env}-tls"
  env_subdomains            = [for subEnv in var.sub_domains : var.env != "production" ? format("%s.%s", subEnv, var.env) : subEnv]
  dns_names                 = [for subEnv in local.env_subdomains : format("%s.%s", subEnv, var.common_domain_name)]
}

resource "kubernetes_manifest" "tls_certificate" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "namespace" = var.namespace
      "name"      = local.tls_certificate_name
    }
    "spec" = {
      "issuerRef" = {
        "name" = var.cluster_issuer_name
        "kind" = "ClusterIssuer"
      }
      "commonName" = var.common_domain_name
      "dnsNames"   = local.dns_names
      "secretName" = local.tls_secret_name
    }
  }
}
