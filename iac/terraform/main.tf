locals {
  primary_email_contact = "poulson.bill@gmail.com"
}

# module "nginx" {
#   source = "./modules/ingress/nginx/"
#   providers = {
#     helm = helm
#   }
# }


# module "cluster_issuer_prod" {
#   source = "./modules/cluster-issuer"
#   providers = {
#     acme       = acme.prod
#     kubernetes = kubernetes
#   }

#   acme_email_contact = local.primary_email_contact
#   name               = "${var.domain_name}-prod"
#   acme_server_url    = var.letsencrypt_acme_server_url_stage
# }

module "dev_env" {
  source = "./environments/dev"

  providers = {
    docker     = docker
    randombyte = randombyte
  }

  kube_context_name = "docker-desktop"

  env                   = var.env
  namespace             = local.env_namespace
  domain_common_name    = "exhelion.net"
  primary_email_contact = local.primary_email_contact
  acme_server_url       = var.letsencrypt_acme_server_url_stage

  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
  ngrok_api_key    = var.ngrok_api_key
  ngrok_authtoken  = var.ngrok_authtoken
}
