# main.tf in the terraform folder
module "docker_module" {
  source = "./docker/"
}

module "helm_module" {
  source                 = "./helm/"
  kubernetes_config_path = var.kubernetes_config_path
  kubernetes_context     = var.kubernetes_context
  ngrok_api_key          = var.ngrok_api_key
  ngrok_authtoken        = var.ngrok_authtoken
  app_namespace          = kubernetes_namespace_v1.sample_app.metadata[0].name
}


