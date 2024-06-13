terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}


# module "templated_app_exhelion" {
#   source              = "./modules/apps/v1/exhelion-app-template"
#   app_namespace       = var.app_namespace
#   domain_name         = var.domain_name
#   public_ingress_port = var.public_ingress_port
#   image_name          = var.image_name
#   tls_secret_name     = var.secret_name
#   # image_version       = "latest" 
#   providers = {
#     docker     = docker
#     kubernetes = kubernetes
#     helm       = helm
#   }
# }
