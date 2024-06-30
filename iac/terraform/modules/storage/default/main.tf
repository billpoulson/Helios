terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

locals {
  storage_name = "${var.volume_name}-${var.env}"
}

resource "kubernetes_persistent_volume" "data_pv" {
  metadata {
    name = "${local.storage_name}-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "manual"
    persistent_volume_source {
      host_path {
        path = "/mnt/data/${var.volume_name}/${var.env}"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "data_pvc" {
  metadata {
    name      = "${local.storage_name}-pvc"
    namespace = var.namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    storage_class_name = "manual"
  }
}


output "pvc_name" {
  value = kubernetes_persistent_volume_claim.data_pvc.metadata[0].name
}
output "pv_name" {
  value = kubernetes_persistent_volume.data_pv.metadata[0].name
}
