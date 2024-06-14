
# resource "kubernetes_ingress_v1" "maint-site" {
#   metadata {
#     namespace = var.app_namespace
#     name      = "maint-site-http-ingress"
#   }
#   spec {
#     ingress_class_name = "ngrok"
#     rule {
#       host = var.domain_name
#       http {
#         path {
#           path = "/maint"
#           backend {
#             service {
#               name = "maint-site"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }


# resource "kubernetes_service_v1" "maint-site" {
#   metadata {
#     namespace = var.app_namespace
#     name      = "maint-site"
#   }
#   spec {
#     port {
#       port        = 80
#       target_port = 80
#     }
#     selector = {
#       app = "maint-site"
#     }
#   }
# }

# resource "kubernetes_deployment_v1" "maint-site" {
#   metadata {
#     namespace = var.app_namespace
#     name      = "maint-site"
#   }
#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         app = "maint-site"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "maint-site"
#         }
#       }
#       spec {
#         container {
#           name  = "backend"
#           image = "wickerlabs/maintenance:latest"
#           port {
#             container_port = 80
#           }
#           env {
#             name  = "PORT"
#             value = "80"
#           }
#           env {
#             name  = "RESPONSE_CODE"
#             value = "200"
#           }
#           env {
#             name  = "THEME"
#             value = "Dark"
#           }
#           env {
#             name  = "TITLE"
#             value = "Under maintenance"
#           }
#           env {
#             name  = "HEADLINE"
#             value = "We'll be right back,"
#           }
#           env {
#             name  = "MESSAGE"
#             value = "Sorry for the inconvenience but we're performing some maintenance at the moment. If you need to you can always {{contact}}, otherwise we'll be back online shortly!...."
#           }
#           env {
#             name  = "TEAM_NAME"
#             value = "Exhelion"
#           }
#           env {
#             name  = "CONTACT_LINK"
#             value = "Contact US"
#           }
#           env {
#             name  = "MAIL_ADDRESS"
#             value = "example@email.com"
#           }
#           # liveness_probe {
#           #   exec {
#           #     command = ["/bin/true"]
#           #   }
#           #   initial_delay_seconds = 3
#           #   period_seconds        = 3
#           # }

#           # readiness_probe {
#           #   exec {
#           #     command = ["/bin/true"]
#           #   }
#           #   initial_delay_seconds = 3
#           #   period_seconds        = 3
#           # }
#         }
#       }
#     }
#   }
# }


# output "maint_service_name" {
#   # value = "maint-site"
#   value = kubernetes_service_v1.maint-site.metadata[0].name
# }
