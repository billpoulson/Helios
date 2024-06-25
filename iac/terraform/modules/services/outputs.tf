
output "name" {
  value = kubernetes_service_v1.service.metadata[0].name
}

output "service_port" {
  value = kubernetes_service_v1.service.spec[0].port[0].port
}
