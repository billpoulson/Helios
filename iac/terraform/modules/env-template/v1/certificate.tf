provider "kubernetes" {
  config_path            = "~/.kube/config"
  config_context_cluster = var.kube_context_name
}

module "certificate" {
  source = "../../certificate"

  providers = {
    acme       = acme
    kubernetes = kubernetes
  }

  env       = var.env
  namespace = var.namespace

  cluster_issuer_name = module.cluster_issuer.name
  common_domain_name  = var.domain_common_name
  email_contact       = var.primary_email_contact
  sub_domains         = ["www", "api"]

}
