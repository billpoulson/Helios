module "nginx-ingress" {
  source                     = "../../ingress/nginx"
  env                        = var.env
  cluster_http_ingress_port  = var.cluster_http_ingress_port
  cluster_https_ingress_port = var.cluster_https_ingress_port
}

module "ingress" {
  source = "../../ingress/nginx/generic_https_ingress"

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
    {
      name         = "deno-1-function-ingress"
      namespace    = var.namespace
      service_name = module.deno_some_test_function_service.name
      service_port = module.deno_some_test_function_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/functions/deno1"
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
