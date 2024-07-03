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
  # acme_server_url       = var.letsencrypt_acmed_server_url_prod
  acme_server_url = var.letsencrypt_acme_server_url_stage

  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
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
  domain_common_name    = "exhelion.local"
  primary_email_contact = local.primary_email_contact
  acme_server_url       = var.letsencrypt_acme_server_url_stage

  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
}


module "docker_desktop_cluster" {
  providers = {
    docker = docker
  }
  source            = "./modules/cluster"
  kube_context_name = "docker-desktop"
}


module "kafka" {
  source = "./modules/mq/kafka"
  namespace = var.app_namespace
}