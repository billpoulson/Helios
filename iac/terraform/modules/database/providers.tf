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
