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


provider "helm" {
  kubernetes {
    config_path    = var.kube_config_path
    config_context = var.kube_context_name
  }
}
provider "kubernetes" {
  config_path            = "~/.kube/config"
  config_context_cluster = var.kube_context_name
}