

provider "kubernetes" {
  config_path = var.kubernetes_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubernetes_config_path
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.6.1"

  namespace = var.app_namespace

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "global.leaderElection.namespace"
    value = kubernetes_namespace.cert_manager.metadata[0].name
  }
}

resource "kubernetes_manifest" "letsencrypt_clusterissuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-prod"
    }
    "spec" = {
      "acme" = {
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "email"  = "poulson.bill@gmail.com"
        "privateKeySecretRef" = {
          "name" = "letsencrypt-prod"
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

resource "kubernetes_ingress" "https_ingress" {
  metadata {
    name      = "https-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class"                       = "nginx"
      "cert-manager.io/cluster-issuer"                    = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/enable-cors"           = "true"
      "nginx.ingress.kubernetes.io/configuration-snippet" = <<-EOT
        more_set_headers 'Access-Control-Allow-Origin: $http_origin';
        more_set_headers 'Access-Control-Allow-Credentials: true';
        more_set_headers 'Access-Control-Allow-Methods: HEAD, GET, POST, OPTIONS, PUT, DELETE';
        more_set_headers 'Access-Control-Allow-Headers: DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
        EOT
    }
  }
  spec {
    rule {
      host = "www.test.com"
      http {
        path {
          path = "/"
          backend {
            service_name = "example-service"
            service_port = 80
          }
        }
      }
    }


  }
}
# resource "kubernetes_ingress" "https_ingress" {
#   metadata {
#     name = "https-ingress"
#     annotations = {
#       "kubernetes.io/ingress.class"                  = "nginx"
#       "cert-manager.io/cluster-issuer"               = "letsencrypt-prod"
#       "nginx.ingress.kubernetes.io/enable-cors"      = "true"
#       "nginx.ingress.kubernetes.io/configuration-snippet" = <<-EOT
#         more_set_headers 'Access-Control-Allow-Origin: $http_origin';
#         more_set_headers 'Access-Control-Allow-Credentials: true';
#         more_set_headers 'Access-Control-Allow-Methods: HEAD, GET, POST, OPTIONS, PUT, DELETE';
#         more_set_headers 'Access-Control-Allow-Headers: DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
#         EOT
#     }
#   }

#   spec {
#     default_backend {
#       service {
#         name = "frontend-service"
#         port {
#           number = 80
#         }
#       }
#     }

#     rule {
#       host = "www.jbinvoiceventures.com"
#       http {
#         path {
#           path     = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = "frontend-service"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }


#   }
# }
