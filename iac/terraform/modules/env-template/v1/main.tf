

provider "helm" {
  kubernetes {
    config_path    = var.kube_config_path
    config_context = var.kube_context_name
  }
}

module "docker_images" {
  source = "../../docker-images/"
  providers = {
    docker = docker
  }
  helios_workspace = var.helios_workspace
}

module "secrets" {
  source        = "../../secrets"
  env           = var.env
  app_namespace = var.namespace
  providers = {
    randombyte = randombyte
  }
}

provider "acme" {
  server_url = var.acme_server_url
}

module "database" {
  source = "../../database"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env                = var.env
  app_namespace      = var.namespace
  maintenance_mode   = var.enable_maintenance
  postgres_password  = module.secrets.sql_sa_password
  kubernetes_context = var.kube_context_name
}

module "storage" {
  source = "../../storage"

  providers = {
    kubernetes = kubernetes
  }

  namespace = var.namespace
  env = var.env
}

module "dotenv" {
  source = "../../dotenv"

  providers = {
    kubernetes = kubernetes
    acme       = acme
  }

  env              = var.env
  secret_name      = var.dot_env_secret
  namespace        = var.namespace
  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
  kube_context     = var.kube_context_name
}
