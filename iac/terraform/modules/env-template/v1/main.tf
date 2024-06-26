

provider "helm" {
  kubernetes {
    config_path    = var.kube_config_path
    config_context = var.kube_context_name
  }
}

module "docker_images" {
  source = "../../docker-images/"
  providers = {
    docker = docker
  }
}

module "secrets" {
  source        = "../../secrets"
  env           = var.env
  app_namespace = var.namespace
  providers = {
    randombyte = randombyte
  }
}

provider "acme" {
  server_url = var.acme_server_url
}

module "database" {
  source = "../../database"

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

# module "ngrok" {
#   source = "../../ingress/ngrok"

#   providers = {
#     kubernetes = kubernetes
#     helm       = helm
#     docker     = docker
#   }

#   app_namespace   = var.namespace
#   ngrok_api_key   = var.ngrok_api_key
#   ngrok_authtoken = var.ngrok_authtoken
# }

module "storage" {
  source = "../../storage"

  providers = {
    kubernetes = kubernetes
  }

  namespace = var.namespace
}

module "dotenv" {
  source = "../../dotenv"

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
