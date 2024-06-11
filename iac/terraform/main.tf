# main.tf in the terraform folder
module "docker_images" {
  source = "./modules/docker-images/"
}

module "nginx" {
  source = "./modules/ingress/nginx/"
}

module "services" {
  source                           = "./modules/services/v1"
  env                              = var.env
  app_namespace                    = kubernetes_namespace_v1.sample_app.metadata[0].name
  maintenance_mode                 = var.enable_maintenance
  maintenance_backend_service_name = module.apps.maint_service_name
  domain_name                      = var.domain_name
  oauth_api_image_name             = module.docker_images.porta_oauth_image_id
  pv_claim_name                    = kubernetes_persistent_volume_claim.data_volumec.metadata[0].name
  docker_image_version             = module.docker_images.porta_oauth_image_id
}

module "apps" {
  source                   = "./modules/apps/v1"
  env                      = var.env
  app_namespace            = kubernetes_namespace_v1.sample_app.metadata[0].name
  domain_name              = var.domain_name
  maintenance_mode         = var.enable_maintenance
  oauth_manager_image_name = module.docker_images.porta_oauth_image_name
  pv_claim_name            = kubernetes_persistent_volume_claim.data_volumec.metadata[0].name
  docker_image_version     = module.docker_images.porta_oauth_image_id
  api_service_name         = module.services.api_service_name
}

module "functions" {
  source                = "./modules/functions/v1"
  env                   = var.env
  app_namespace         = kubernetes_namespace_v1.sample_app.metadata[0].name
  domain_name           = var.domain_name
  function_a_image_name = module.docker_images.v1_functions_smoke_test_image_name_id
}

module "database" {
  source            = "./modules/database/"
  env               = var.env
  app_namespace     = kubernetes_namespace_v1.sample_app.metadata[0].name
  maintenance_mode  = var.enable_maintenance
  postgres_password = local.postgres_password
}

module "ngrok" {
  source                 = "./modules/ingress/ngrok"
  app_namespace          = kubernetes_namespace_v1.sample_app.metadata[0].name
  kubernetes_config_path = var.kubernetes_config_path
  kubernetes_context     = var.kubernetes_context
  ngrok_api_key          = var.ngrok_api_key
  ngrok_authtoken        = var.ngrok_authtoken
}

# module "cert_manager" {
#   source = "./cert-manager/lets-encrypt/"
# }
