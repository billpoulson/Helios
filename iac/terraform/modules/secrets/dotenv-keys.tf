data "external" "dotenv_keys_json_generator" {
  program     = ["py", "${var.helios_runner}", "--env", "dev", "--commands", "util.dotenv-export"]
  working_dir = var.helios_workspace
}

data "local_file" "dotenv_keys_json" {
  depends_on = [data.external.dotenv_keys_json_generator]
  filename   = "${var.helios_workspace}/dotenv.keys.json"
}

resource "kubernetes_secret_v1" "dotenv_secret" {
  depends_on = [data.local_file.dotenv_keys_json]

  for_each = jsondecode(data.local_file.dotenv_keys_json.content)

  metadata {
    namespace = var.app_namespace
    name      = "dotenv-keys-${each.key}"
  }
  type = "Opaque"

  data = each.value
}
