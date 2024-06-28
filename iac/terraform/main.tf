locals {
  primary_email_contact = "poulson.bill@gmail.com"
}

module "prod_env" {
  source = "./modules/env-template/v1"

  providers = {
    docker     = docker
    randombyte = randombyte
  }

  kube_context_name = "docker-desktop"

  env                   = var.env
  namespace             = local.env_namespace
  domain_common_name    = "exhelion.net"
  primary_email_contact = local.primary_email_contact
  acme_server_url       = var.letsencrypt_acmed_server_url_prod

  helios_runner              = var.helios_runner
  helios_workspace           = var.helios_workspace
  ngrok_api_key              = var.ngrok_api_key
  ngrok_authtoken            = var.ngrok_authtoken
  cluster_http_ingress_port  = var.cluster_http_ingress_port
  cluster_https_ingress_port = var.cluster_https_ingress_port
}

module "dev_env" {
  source = "./modules/env-template/v1"

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

  helios_runner              = var.helios_runner
  helios_workspace           = var.helios_workspace
  ngrok_api_key              = var.ngrok_api_key
  ngrok_authtoken            = var.ngrok_authtoken
  cluster_http_ingress_port  = var.cluster_http_ingress_port
  cluster_https_ingress_port = var.cluster_https_ingress_port
}
