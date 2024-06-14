
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
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0" # Specify the version you want to use
    }
  }
}
