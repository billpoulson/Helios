terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    kafka = {
      source  = "Mongey/kafka"
      version = "~> 0.7.1"
    }
  }
}
