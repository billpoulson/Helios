# resource "kubernetes_config_map" "zookeeper_config" {
#   metadata {
#     name      = "zookeeper-config"
#     namespace = var.namespace
#     labels = {
#       app = "zookeeper"
#     }
#   }

#   data = {
#     "zoo.cfg" = <<-EOT
#       tickTime=2000
#       initLimit=5
#       syncLimit=2
#       dataDir=/var/lib/zookeeper/data
#       dataLogDir=/var/lib/zookeeper/log
#       clientPort=2181
#       server.1=zookeeper-0.zookeeper-headless.${var.namespace}.svc.cluster.local:2888:3888
#       server.2=zookeeper-1.zookeeper-headless.${var.namespace}.svc.cluster.local:2888:3888
#       server.3=zookeeper-2.zookeeper-headless.${var.namespace}.svc.cluster.local:2888:3888
#     EOT
#   }
# }

# resource "kubernetes_service_v1" "zookeeper_headless" {
#   metadata {
#     name      = "zookeeper-headless"
#     namespace = var.namespace
#     labels = {
#       app = "zookeeper"
#     }
#   }

#   spec {
#     type       = "ClusterIP"
#     cluster_ip = "None"
#     selector = {
#       app = "zookeeper"
#     }

#     port {
#       port        = 2181
#       target_port = 2181
#       name        = "client"
#     }

#     port {
#       port        = 2888
#       target_port = 2888
#       name        = "follower"
#     }

#     port {
#       port        = 3888
#       target_port = 3888
#       name        = "leader"
#     }
#   }
# }

# resource "kubernetes_stateful_set" "zookeeper" {
#   metadata {
#     name      = "zookeeper"
#     namespace = var.namespace
#     labels = {
#       app = "zookeeper"
#     }
#   }

#   spec {
#     service_name = "zookeeper-headless"
#     replicas     = 3
#     selector {
#       match_labels = {
#         app = "zookeeper"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "zookeeper"
#         }
#       }

#       spec {
#         container {
#           name  = "zookeeper"
#           image = "wurstmeister/zookeeper:3.4.6"

#           port {
#             container_port = 2181
#             name           = "client"
#           }

#           port {
#             container_port = 2888
#             name           = "follower"
#           }

#           port {
#             container_port = 3888
#             name           = "leader"
#           }

#           volume_mount {
#             name       = "data"
#             mount_path = "/var/lib/zookeeper"
#           }

#           env {
#             name = "ZOO_MY_ID"
#             value_from {
#               field_ref {
#                 field_path = "metadata.name"
#               }
#             }
#           }

#           env {
#             name  = "ZK_SERVER_1"
#             value = "zookeeper-0.zookeeper-headless.${var.namespace}.svc.cluster.local:2888:3888"
#           }

#           env {
#             name  = "ZK_SERVER_2"
#             value = "zookeeper-1.zookeeper-headless.${var.namespace}.svc.cluster.local:2888:3888"
#           }

#           env {
#             name  = "ZK_SERVER_3"
#             value = "zookeeper-2.zookeeper-headless.${var.namespace}.svc.cluster.local:2888:3888"
#           }
#         }

#         volume {
#           name = "data"
#           persistent_volume_claim {
#             claim_name = "zookeeper-pvc"
#           }
#         }
#       }
#     }

#     volume_claim_template {
#       metadata {
#         name = "zookeeper-pvc"
#       }

#       spec {
#         access_modes = ["ReadWriteOnce"]
#         resources {
#           requests = {
#             storage = "1Gi"
#           }
#         }
#       }
#     }
#   }
# }

# output "zookeeper_headless_service" {
#   value = "zookeeper-headless.${var.namespace}.svc.cluster.local:${
#     [for p in kubernetes_service_v1.zookeeper_headless.spec.0.port : p.port if p.name == "client"][0]
#   }"
# }
