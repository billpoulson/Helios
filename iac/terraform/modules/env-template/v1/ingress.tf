module "nginx-ingress" {
  source                     = "../../ingress/nginx"
  env                        = var.env
  cluster_http_ingress_port  = var.cluster_http_ingress_port
  cluster_https_ingress_port = var.cluster_https_ingress_port
}

module "ingress_http" {
  source    = "../../ingress/nginx/generic_http_ingress"
  namespace = var.namespace
  
  maint_route = {
    enable_maintenance = false
    service_name       = module.maint_site_service.name
    service_port       = module.maint_site_service.service_port
  }

  ingresses = [
    {
      name         = "www-ingress"
      service_name = module.simple_oauth_service.name
      service_port = module.simple_oauth_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/manage"
    },
    {
      name         = "maint-site"
      service_name = module.maint_site_service.name
      service_port = module.maint_site_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/"
    },
    {
      name         = "api-ingress"
      service_name = module.simple_oauth_service_api.name
      service_port = module.simple_oauth_service_api.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/api"
    },
    {
      name         = "api-subdomain-ingress"
      service_name = module.simple_oauth_service_api_subdomain.name
      service_port = module.simple_oauth_service_api_subdomain.service_port
      host         = "api.${var.domain_common_name}"
      path         = "/"
    },
    {
      name         = "express-1-function-ingress"
      service_name = module.express_test_function_service.name
      service_port = module.express_test_function_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/functions/express1"
    },
    {
      name         = "express-1-function-ingress2"
      service_name = module.express_test_function_service.name
      service_port = module.express_test_function_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/functions/express2"
    },
    {
      name         = "express-1-function-ingress3"
      service_name = module.express_test_function_service.name
      service_port = module.express_test_function_service.service_port
      host         = "www.${var.domain_common_name}"
      path         = "/functions/express3"
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


# module "ingress" {
#   source = "../../ingress/nginx/generic_https_ingress"

#   cluster_issuer = module.cluster_issuer.name

#   ingresses = [
#     {
#       name         = "www-ingress"
#       namespace    = var.namespace
#       service_name = module.simple_oauth_service.name
#       service_port = module.simple_oauth_service.service_port
#       host         = "www.${var.domain_common_name}"
#       path         = "/manage"
#       tls = [{
#         hosts       = ["www.${var.domain_common_name}"]
#         secret_name = module.certificate.tls_secret_name
#       }]
#     },
#     {
#       name         = "maint-site"
#       namespace    = var.namespace
#       service_name = module.maint_site_service.name
#       service_port = module.maint_site_service.service_port
#       host         = "www.${var.domain_common_name}"
#       path         = "/"
#       tls = [{
#         hosts       = ["www.${var.domain_common_name}"]
#         secret_name = module.certificate.tls_secret_name
#       }]
#     },
#     {
#       name         = "api-ingress"
#       namespace    = var.namespace
#       service_name = module.simple_oauth_service.name
#       service_port = module.simple_oauth_service.service_port
#       host         = "www.${var.domain_common_name}"
#       path         = "/api"
#       tls = [{
#         hosts       = ["www.${var.domain_common_name}"]
#         secret_name = module.certificate.tls_secret_name
#       }]
#     },
#     # {
#     #   name         = "deno-1-function-ingress"
#     #   namespace    = var.namespace
#     #   service_name = module.express_test_function_service.name
#     #   service_port = module.express_test_function_service.service_port
#     #   host         = "www.${var.domain_common_name}"
#     #   path         = "/functions/deno1"
#     #   tls = [{
#     #     hosts       = ["www.${var.domain_common_name}"]
#     #     secret_name = module.certificate.tls_secret_name
#     #   }]
#     # },
#     # {
#     #   name         = "app-ingress"
#     #   namespace    = var.namespace
#     #   service_name = module.simple_oauth_service.name
#     #   service_port = module.simple_oauth_service.service_port
#     #   host         = "app.${var.domain_common_name}"
#     #   path         = "/"
#     #   tls = [{
#     #     hosts       = ["app.${var.domain_common_name}"]
#     #     secret_name = module.certificate.tls_secret_name
#     #   }]
#     # },
#     # {
#     #   name         = "www-ingress-manager"
#     #   namespace    = var.namespace
#     #   service_name = module.simple_oauth_service.name
#     #   service_port = module.simple_oauth_service.service_port
#     #   host         = "www.${var.domain_common_name}"
#     #   path         = "/manage"
#     #   tls = [{
#     #     hosts       = ["app.${var.domain_common_name}"]
#     #     secret_name = module.certificate.tls_secret_name
#     #   }]
#     # }
#   ]
# }
