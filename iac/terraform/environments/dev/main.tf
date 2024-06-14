# module "docker_images" {
#   source = "./modules/docker-images/"
#   providers = {
#     docker = docker
#   }
# }

# module "nginx" {
#   source = "./modules/ingress/nginx/"
#   providers = {
#     helm = helm
#   }
# }
module "secrets" {
  source        = "../../modules/secrets"
  env           = var.env
  app_namespace = var.env_namespace
  providers = {
    randombyte = randombyte
  }
}

module "services" {
  source     = "../../modules/services/v1"
  depends_on = [module.dotenv]
  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env                              = var.env
  app_namespace                    = var.env_namespace
  maintenance_mode                 = var.enable_maintenance
  maintenance_backend_service_name = "maint-site"
  domain_name                      = var.domain_name
  pv_claim_name                    = module.storage.pv_claim_name
  oauth_api_image_name             = "porta-oauthx-v1"
  # docker_image_version             = module.docker_images.porta_oauth_image_id
}

module "apps" {
  source     = "../../modules/apps/v1"
  depends_on = [module.dotenv]
  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  public_ingress_port      = 31080
  env                      = var.env
  app_namespace            = var.env_namespace
  domain_name              = var.domain_name
  maintenance_mode         = var.enable_maintenance
  pv_claim_name            = module.storage.pv_claim_name
  docker_image_version     = var.docker_image_version
  oauth_manager_image_name = "porta-oauthx-v1"
  # api_service_name         = "porta-oauthx-v1"
}

module "functions" {
  depends_on = [module.dotenv]
  source     = "../../modules/functions/v1"
  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env                   = var.env
  app_namespace         = var.env_namespace
  domain_name           = var.domain_name
  function_a_image_name = "v1-functions-smoke-test"
  deno_image_name       = "v1-functions-smoke-test-deno"
}

module "database" {
  source = "../../modules/database"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env               = var.env
  app_namespace     = var.env_namespace
  maintenance_mode  = var.enable_maintenance
  postgres_password = module.secrets.sql_sa_password
}

module "ngrok" {
  source = "../../modules/ingress/ngrok"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  app_namespace   = var.env_namespace
  ngrok_api_key   = var.ngrok_api_key
  ngrok_authtoken = var.ngrok_authtoken
}

module "acme" {

  source = "../../modules/acme/lets-encrypt/"

  providers = {
    kubernetes = kubernetes
    # acme       = acme
  }

  app_namespace = var.env_namespace
}

module "storage" {
  source        = "../../modules/storage"
  app_namespace = var.env_namespace
}



module "dotenv" {
  source           = "../../modules/dotenv"
  env              = var.env
  app_namespace    = var.env_namespace
  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
  providers = {
    kubernetes = kubernetes
    acme       = acme
  }
}
