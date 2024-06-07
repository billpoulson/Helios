
resource "kubernetes_persistent_volume" "data_volume" {
  metadata {
    name = "example-pv"
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
        path = "/mnt/data"
      }
    }
  }
}
# Persistent Volume Claim
resource "kubernetes_persistent_volume_claim" "data_volumec" {
  metadata {
    name      = "example-pvc"
    namespace = var.app_namespace
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
