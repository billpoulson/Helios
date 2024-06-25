terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
  }
}
