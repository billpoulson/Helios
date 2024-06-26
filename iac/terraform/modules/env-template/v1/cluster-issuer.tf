
module "cluster_issuer" {
  source = "../../cluster-issuer"

  providers = {
    acme       = acme
    kubernetes = kubernetes
  }

  name               = "${var.domain_common_name}-${var.env}"
  acme_email_contact = var.primary_email_contact
  acme_server_url    = var.acme_server_url

}
