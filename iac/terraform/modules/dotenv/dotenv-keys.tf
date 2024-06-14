data "external" "dotenv_keys_json_generator" {
  program     = ["py", var.helios_runner, "--env", "dev", "--commands", "util.dotenv-export"]
  working_dir = var.helios_workspace
}

resource "kubernetes_secret_v1" "dotenv_secret" {
  depends_on = [data.external.dotenv_keys_json_generator]
  metadata {
    namespace = var.app_namespace
    name      = "dotenv-keys"
  }
  type = "Opaque"

  data = data.external.dotenv_keys_json_generator.result
}
