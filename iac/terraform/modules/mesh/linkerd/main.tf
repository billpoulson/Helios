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

  certificate_duration      = "7776000s" // 90 days in seconds
  certificate_creation_time = timestamp()
  certificate_expiry_time   = timeadd(local.certificate_creation_time, local.certificate_duration)
}


resource "kubernetes_manifest" "tls_certificate" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "namespace" = var.namespace
      "name"      = "linkerd-identity-issuer"
    }
    "spec" = {
      "issuerRef" = {
        "name" = var.cluster_issuer_name
        "kind" = "ClusterIssuer"
      }
      "commonName"  = var.common_domain_name
      "dnsNames"    = [var.common_domain_name]
      "secretName"  = "linkerd-identity-issuer-tls"
      "duration"    = "2160h0m0s" # 90 days
      "renewBefore" = "360h0m0s"  # 15 days before expiry
    }
  }
}

data "kubernetes_secret" "linkerd_identity_issuer_tls" {
  depends_on = [kubernetes_manifest.tls_certificate]

  metadata {
    name      = "linkerd-identity-issuer-tls"
    namespace = var.namespace
  }
}

# New null_resource to wait for the secret
resource "null_resource" "wait_for_secret" {
  depends_on = [kubernetes_manifest.tls_certificate]

  provisioner "local-exec" {
    command = <<EOT
      while ! kubectl get secret linkerd-identity-issuer-tls -n ${var.namespace}; do
        echo "Waiting for secret to be created..."
        sleep 10
      done
    EOT
  }
}



output "linkerd_identity_issuer_tls_secret" {
  value = data.kubernetes_secret.linkerd_identity_issuer_tls.data
}

resource "helm_release" "linkerd_control_plane" {
  depends_on = [null_resource.wait_for_secret]
  name       = "linkerd-control-plane"
  namespace  = var.namespace
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  version    = "2.11.1"

  values = [
    <<EOF
    global:
      identityTrustAnchorsPEM: |
        ${data.kubernetes_secret.linkerd_identity_issuer_tls.data["ca.crt"]}
      identity:
        issuer:
          scheme: linkerd.io/tls
          crtExpiry: "${local.certificate_expiry_time}"
          tls:
            crtPEM: |
              ${data.kubernetes_secret.linkerd_identity_issuer_tls.data["tls.crt"]}
            keyPEM: |
              ${data.kubernetes_secret.linkerd_identity_issuer_tls.data["tls.key"]}
    EOF
  ]
}
