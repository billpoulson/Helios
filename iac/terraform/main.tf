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


module "cloud_env" {
  source     = "./environments/dev"
  depends_on = [module.docker_images]

  providers = {
    helm       = helm
    kubernetes = kubernetes
    docker     = docker
    acme       = acme.stage
    randombyte = randombyte
  }

  env              = var.env
  env_namespace    = local.env_namespace
  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
  ngrok_api_key    = var.ngrok_api_key
  ngrok_authtoken  = var.ngrok_authtoken
  domain_name      = var.domain_name
}
