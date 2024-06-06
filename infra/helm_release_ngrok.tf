resource "helm_release" "ngrok-ingress-controller" {
  namespace  = kubernetes_namespace_v1.sample_app.metadata[0].name
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

# resource "helm_release" "ngrok-ingress-controller" {
#   namespace  = kubernetes_namespace_v1.sample_app.metadata[0].name
#   name       = "ngrok-ingress-controller"
#   repository = "https://ngrok.github.io/kubernetes-ingress-controller"
#   chart      = "kubernetes-ingress-controller"

#   set {
#     name  = "credentials.apiKey"
#     value = var.ngrok_api_key
#   }
#   set {
#     name  = "credentials.authtoken"
#     value = var.ngrok_authtoken
#   }

# }


