# main.tf in the terraform folder
module "docker_images" {
  source   = "./docker-images/"
  versions = ["v1.0", "v1.1", "v1.2"]
}

module "apps" {
  source                   = "./apps/"
  env                      = var.env
  app_namespace            = kubernetes_namespace_v1.sample_app.metadata[0].name
  domain_name              = var.domain_name
  maintenance_mode         = var.enable_maintenance
  oauth_manager_image_name = module.docker_images.porta_oauth_image_name
  pv_claim_name            = kubernetes_persistent_volume_claim.data_volumec.metadata[0].name
  docker_image_version     = module.docker_images.porta_oauth_image_id
}

module "services" {
  source                           = "./services/"
  env                              = var.env
  app_namespace                    = kubernetes_namespace_v1.sample_app.metadata[0].name
  maintenance_mode                 = var.enable_maintenance
  maintenance_backend_service_name = module.apps.maint_service_name
  domain_name                      = var.domain_name
  oauth_api_image_name             = module.docker_images.porta_oauth_image_id
  pv_claim_name                    = kubernetes_persistent_volume_claim.data_volumec.metadata[0].name
  docker_image_version             = module.docker_images.porta_oauth_image_id

}

module "database" {
  source            = "./database/"
  env               = var.env
  app_namespace     = kubernetes_namespace_v1.sample_app.metadata[0].name
  maintenance_mode  = var.enable_maintenance
  postgres_password = local.postgres_password
}

module "ngrok" {
  source                 = "./ingress/ngrok"
  app_namespace          = kubernetes_namespace_v1.sample_app.metadata[0].name
  kubernetes_config_path = var.kubernetes_config_path
  kubernetes_context     = var.kubernetes_context
  ngrok_api_key          = var.ngrok_api_key
  ngrok_authtoken        = var.ngrok_authtoken
}


# module "cert_manager" {
#   source = "./cert-manager/lets-encrypt/"
# }
