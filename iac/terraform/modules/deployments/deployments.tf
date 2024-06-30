resource "null_resource" "linkerd_inject" {
  provisioner "local-exec" {
    command = "kubectl get deployment ${kubernetes_deployment_v1.deployment.metadata[0].name} -n ${var.namespace} -o yaml | linkerd inject - | kubectl apply -f -"
  }

  depends_on = [kubernetes_deployment_v1.deployment]
}

resource "kubernetes_deployment_v1" "deployment" {

  metadata {
    namespace = var.namespace
    name      = var.name
    annotations = {
      "linkerd.io/inject" = "enabled"
    }
  }

  spec {
    replicas = var.replicas
    strategy {
      type = "RollingUpdate"
    }
    selector {
      match_labels = {
        app = var.name
      }
    }

    template {

      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          name              = var.name
          image             = var.image
          image_pull_policy = var.image_pull_policy

          port {
            container_port = var.container_port
          }

          env {
            name = "DOTENV_KEY"
            value_from {
              secret_key_ref {
                name = var.dot_env_secret
                key  = var.dot_env_key
              }
            }
          }

          volume_mount {
            name       = "data"
            mount_path = "/app/data"
          }
        }

        volume {
          name = "data"
          persistent_volume_claim {
            claim_name = var.default_volume_pvc_name
          }
        }
      }
    }
  }
}
