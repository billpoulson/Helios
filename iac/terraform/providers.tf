
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
provider "null" {

}

# "registry.terraform.io/hashicorp/null"
provider "helm" {
  kubernetes {
    config_path = var.kubernetes_config_path
  }
}

provider "kubernetes" {
  config_path    = var.kubernetes_config_path
  config_context = var.kubernetes_context
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

# provider "acme" {
#   server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
# }
