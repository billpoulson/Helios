module "nginx-ingress" {
  source                     = "../../modules/ingress/nginx"
  cluster_http_ingress_port  = 31080
  cluster_https_ingress_port = 31443
}

module "ingress" {
  source = "../../modules/ingress/nginx/generic_https_ingress"

  cluster_issuer = module.cluster_issuer.name

  ingresses = [
    {
      name         = "www-ingress"
      namespace    = var.namespace
      service_name = module.simple_oauth_service.name
      service_port = module.simple_oauth_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/manage"
      tls = [{
        hosts       = ["www.${var.domain_common_name}"]
        secret_name = module.certificate.tls_secret_name
      }]
    },
    {
      name         = "maint-site"
      namespace    = var.namespace
      service_name = module.maint_site_service.name
      service_port = module.maint_site_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/"
      tls = [{
        hosts       = ["www.${var.domain_common_name}"]
        secret_name = module.certificate.tls_secret_name
      }]
    },
    {
      name         = "api-ingress"
      namespace    = var.namespace
      service_name = module.simple_oauth_service.name
      service_port = module.simple_oauth_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/api"
      tls = [{
        hosts       = ["www.${var.domain_common_name}"]
        secret_name = module.certificate.tls_secret_name
      }]
    },
    # {
    #   name         = "app-ingress"
    #   namespace    = var.namespace
    #   service_name = module.simple_oauth_service.name
    #   service_port = module.simple_oauth_service.service_port
    #   host         = "app.${var.domain_common_name}"
    #   path         = "/"
    #   tls = [{
    #     hosts       = ["app.${var.domain_common_name}"]
    #     secret_name = module.certificate.tls_secret_name
    #   }]
    # },
    # {
    #   name         = "www-ingress-manager"
    #   namespace    = var.namespace
    #   service_name = module.simple_oauth_service.name
    #   service_port = module.simple_oauth_service.service_port
    #   host         = "www.${var.domain_common_name}"
    #   path         = "/manage"
    #   tls = [{
    #     hosts       = ["app.${var.domain_common_name}"]
    #     secret_name = module.certificate.tls_secret_name
    #   }]
    # }
  ]
}
