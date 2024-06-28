# module "linkerd" {
#   source = "../../mesh/linkerd"

#   providers = {
#     acme       = acme
#     kubernetes = kubernetes
#   }

#   env       = var.env
#   namespace = var.namespace

#   cluster_issuer_name = module.cluster_issuer.name
#   common_domain_name  = var.domain_common_name
#   email_contact       = var.primary_email_contact
#   sub_domains         = ["www", "api"]

# }