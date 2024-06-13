module "smoke-test-22" {
  source               = "./v1function"
  env                  = var.env
  app_namespace        = var.app_namespace
  api_version          = "v1"
  edge_function_name   = "smoke-test-22"
  domain_name          = var.domain_name
  docker_image_version = var.docker_image_version
  docker_image_name    = var.function_a_image_name
}
