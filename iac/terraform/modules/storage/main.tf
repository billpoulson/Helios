terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

module "default_volume" {
  source      = "../../modules/storage/default"
  namespace   = var.namespace
  env         = var.env
  volume_name = "default"
}

output "default_volume_pv_name" {
  value = module.default_volume.pv_name
}
output "default_volume_pvc_name" {
  value = module.default_volume.pvc_name
}
