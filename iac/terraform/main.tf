module "docker_images" {
  source = "./modules/docker-images/"
  providers = {
    docker = docker
  }
}

module "nginx" {
  source = "./modules/ingress/nginx/"
  providers = {
    helm = helm
  }
}

module "services" {
  source = "./modules/services/v1"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env                              = var.env
  app_namespace                    = kubernetes_namespace_v1.sample_app.metadata[0].name
  maintenance_mode                 = var.enable_maintenance
  maintenance_backend_service_name = module.apps.maint_service_name
  domain_name                      = var.domain_name
  oauth_api_image_name             = module.docker_images.porta_oauth_image_id
  pv_claim_name                    = module.storage.pv_claim_name
  docker_image_version             = module.docker_images.porta_oauth_image_id
}

module "apps" {
  source = "./modules/apps/v1"
  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  public_ingress_port      = 31080
  env                      = var.env
  app_namespace            = kubernetes_namespace_v1.sample_app.metadata[0].name
  domain_name              = var.domain_name
  maintenance_mode         = var.enable_maintenance
  oauth_manager_image_name = module.docker_images.porta_oauth_image_name
  pv_claim_name            = module.storage.pv_claim_name
  docker_image_version     = module.docker_images.porta_oauth_image_id
  api_service_name         = module.services.api_service_name
}

module "functions" {
  source = "./modules/functions/v1"
  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env                   = var.env
  app_namespace         = kubernetes_namespace_v1.sample_app.metadata[0].name
  domain_name           = var.domain_name
  function_a_image_name = module.docker_images.v1_functions_smoke_test_image_name_id
  deno_image_name       = module.docker_images.v1_functions_smoke_test_deno_image_name_id
}

module "database" {
  source = "./modules/database/"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env               = var.env
  app_namespace     = kubernetes_namespace_v1.sample_app.metadata[0].name
  maintenance_mode  = var.enable_maintenance
  postgres_password = local.postgres_password
}

module "ngrok" {
  source = "./modules/ingress/ngrok"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  app_namespace   = kubernetes_namespace_v1.sample_app.metadata[0].name
  ngrok_api_key   = var.ngrok_api_key
  ngrok_authtoken = var.ngrok_authtoken
}

module "acme" {
  source = "./modules/acme/lets-encrypt/"
  providers = {
    kubernetes = kubernetes
    acme       = acme
  }
  app_namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
}

module "storage" {
  source        = "./modules/storage"
  app_namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
}

module "secrets" {
  source           = "./modules/secrets"
  app_namespace    = kubernetes_namespace_v1.sample_app.metadata[0].name
  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
  providers = {
    randombyte = randombyte
  }
}
