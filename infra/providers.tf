
terraform {

  required_providers {
    randombyte = {
      source  = "Socolin/randombyte"
      version = "1.0.2"
    }
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

provider "helm" {
  kubernetes {
    config_path = var.kubernetes_config_path
  }
}

provider "kubernetes" {
  config_path    = var.kubernetes_config_path
  config_context = var.kubernetes_context
}
