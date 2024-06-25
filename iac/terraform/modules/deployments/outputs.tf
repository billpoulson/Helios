output "name" {
  description = "name of the deployment"
  value       = kubernetes_deployment_v1.deployment.metadata.0.name
}
