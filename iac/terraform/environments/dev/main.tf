

provider "helm" {
  kubernetes {
    config_path    = var.kube_config_path
    config_context = var.kube_context_name
  }
}

module "docker_images" {
  source = "../../modules/docker-images/"
  providers = {
    docker = docker
  }
}

module "secrets" {
  source        = "../../modules/secrets"
  env           = var.env
  app_namespace = var.namespace
  providers = {
    randombyte = randombyte
  }
}

# module "apps_v1" {
#   source     = "../../modules/apps/v1"
#   depends_on = [module.storage, module.dotenv]
#   providers = {
#     kubernetes = kubernetes
#     helm       = helm
#     docker     = docker
#   }

#   public_ingress_port      = 31080
#   env                      = var.env
#   app_namespace            = var.namespace
#   domain_name              = var.domain_name
#   maintenance_mode         = var.enable_maintenance
#   pv_claim_name            = module.storage.default_volume_pvc_name
#   docker_image_version     = var.docker_image_version
#   oauth_manager_image_name = module.docker_images.porta_oauth_image_name
#   # api_service_name         = "porta-oauthx-v1"
# }

# module "functions" {
#   depends_on = [module.storage, module.dotenv]
#   source     = "../../modules/functions/v1"
#   providers = {
#     kubernetes = kubernetes
#     helm       = helm
#     docker     = docker
#   }

#   env                   = var.env
#   app_namespace         = var.namespace
#   domain_name           = var.domain_name
#   function_a_image_name = module.docker_images.v1_functions_smoke_test_image_name
#   deno_image_name       = module.docker_images.v1_functions_smoke_test_deno_image_name
#   pv_claim_name         = module.storage.default_volume_pvc_name
# }

provider "acme" {
  server_url = var.acme_server_url
}

module "database" {
  source = "../../modules/database"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  env                = var.env
  app_namespace      = var.namespace
  maintenance_mode   = var.enable_maintenance
  postgres_password  = module.secrets.sql_sa_password
  kubernetes_context = var.kube_context_name
}

module "ngrok" {
  source = "../../modules/ingress/ngrok"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    docker     = docker
  }

  app_namespace   = var.namespace
  ngrok_api_key   = var.ngrok_api_key
  ngrok_authtoken = var.ngrok_authtoken
}

module "storage" {
  source = "../../modules/storage"

  providers = {
    kubernetes = kubernetes
  }

  namespace = var.namespace
}



module "dotenv" {
  source = "../../modules/dotenv"

  providers = {
    kubernetes = kubernetes
    acme       = acme
  }

  env              = var.env
  secret_name      = var.dot_env_secret
  namespace        = var.namespace
  helios_runner    = var.helios_runner
  helios_workspace = var.helios_workspace
  kube_context     = var.kube_context_name
}

# resource "kubernetes_manifest" "kubernetes_admin_services_cluster_role" {
#   manifest = {
#     "kind" : "ClusterRole",
#     "apiVersion" : "rbac.authorization.k8s.io/v1",
#     "metadata" : {
#       "name" : "nginx-access-clusterrole"
#     },
#     "rules" : [
#       {
#         "apiGroups" : [
#           ""
#         ],
#         "resources" : [
#           "services"
#         ],
#         "verbs" : [
#           "get"
#         ]
#       }
#     ]
#   }
# }
# resource "kubernetes_manifest" "kubernetes_admin_services_role_binding" {
#   depends_on = [kubernetes_manifest.kubernetes_admin_services_cluster_role]
#   manifest = {
#     "kind" : "ClusterRoleBinding",
#     "apiVersion" : "rbac.authorization.k8s.io/v1",
#     "metadata" : {
#       "name" : "nginx-access-clusterrolebinding"
#     },
#     "subjects" : [
#       {
#         "kind" : "User",
#         "name" : "kubernetes-admin",
#         "apiGroup" : "rbac.authorization.k8s.io"
#       }
#     ],
#     "roleRef" : {
#       "kind" : "ClusterRole",
#       "name" : "nginx-access-clusterrole",
#       "apiGroup" : "rbac.authorization.k8s.io"
#     }
#   }

# }
