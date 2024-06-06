
# resource "kubernetes_ingress_v1" "game_2048" {
#   metadata {
#     namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
#     name      = "maint-site"
#   }
#   spec {
#     ingress_class_name = "ngrok"
#     rule {
#       host = var.domain_name
#       http {
#         path {
#           path = "/"
#           backend {
#             service {
#               name = kubernetes_service_v1.game_2048.metadata[0].name
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

# resource "kubernetes_service_v1" "game_2048" {
#   metadata {
#     namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
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
# resource "kubernetes_deployment_v1" "game_2048" {
#   metadata {
#     namespace = kubernetes_namespace_v1.sample_app.metadata[0].name
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
#           image = "wickerlabs/maintenance:${var.docker_image_version}"
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
#             value = "Kyros Digital"
#           }
#           env {
#             name  = "CONTACT_LINK"
#             value = "Contact US"
#           }
#           env {
#             name  = "MAIL_ADDRESS"
#             value = "william.poulson@kyrosdigital.com"
#           }
#         }
#       }
#     }
#   }
# }
