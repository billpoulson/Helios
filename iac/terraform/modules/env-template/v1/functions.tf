module "express_test_function_deployment" {
  source = "../../deployments"

  namespace               = var.namespace
  name                    = "exress-smoke-test-1"
  image                   = module.docker_images.v1_functions_smoke_test_image_name
  dot_env_secret          = var.dot_env_secret
  dot_env_key             = "express-smoke-test-1"
  default_volume_pvc_name = module.storage.default_volume_pvc_name
  container_port          = "8080"
  replicas = 10
}
