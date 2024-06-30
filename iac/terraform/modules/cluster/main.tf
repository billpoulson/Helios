module "nginx-ingress" {
  source            = "../ingress/nginx"
  kube_context_name = var.kube_context_name

}
