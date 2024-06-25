

module "simple_oauth_service" {
  source        = "../../../modules/services/v1/simple_oauth"
  env           = var.env
  app_namespace = var.app_namespace
  domain_name   = var.domain_name

  expose_port    = 80
  container_port = 8000

  maintenance_backend_service_name = var.maintenance_backend_service_name
  docker_image                     = var.oauth_api_image_name
  pv_claim_name                    = var.pv_claim_name
}
