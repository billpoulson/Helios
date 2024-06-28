
module "simple_oauth_service" {
  source         = "../../services"
  env            = var.env
  namespace      = var.namespace
  name           = kubernetes_deployment_v1.oauth_manager.metadata[0].name
  expose_port    = 80
  container_port = 8000
}

module "simple_oauth_service_api" {
  source         = "../../services"
  env            = var.env
  namespace      = var.namespace
  name           = kubernetes_deployment_v1.oauth_manager_api.metadata[0].name
  expose_port    = 80
  container_port = 8000
}

module "simple_oauth_service_api_subdomain" {
  source         = "../../services"
  env            = var.env
  namespace      = var.namespace
  name           = kubernetes_deployment_v1.oauth_manager_api_subdomain.metadata[0].name
  expose_port    = 80
  container_port = 8000
}

module "maint_site_service" {
  source         = "../../services"
  env            = var.env
  namespace      = var.namespace
  name           = kubernetes_deployment_v1.maint-site.metadata[0].name
  expose_port    = 80
  container_port = 80
}

module "express_test_function_service" {
  source         = "../../services"
  env            = var.env
  namespace      = var.namespace
  name           = module.express_test_function_deployment.name
  expose_port    = 80
  container_port = 8080
}

