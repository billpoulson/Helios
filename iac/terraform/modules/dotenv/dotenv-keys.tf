// Retrieves the dotenv_keys from the source json file using external data source
data "external" "dotenv_keys_json_generator" {
  program     = ["python3", var.helios_runner, "--env", var.env, "--commands", "util.dotenv-export"]
  working_dir = var.helios_workspace
}

// Create a Kubernetes Secret containing the dotenv_keys
resource "kubernetes_secret_v1" "dotenv_secret" {
  // The secret depends on the external dotenv_keys_json_generator
  depends_on = [data.external.dotenv_keys_json_generator]

  // Metadata for the secret
  metadata {
    // Namespace where the secret will live
    namespace = var.namespace
    // Name to be given to the secret
    name = var.secret_name
  }

  type = "Opaque"

  // Secret data will be the result from the dotenv_keys_json_generator data source
  data = data.external.dotenv_keys_json_generator.result
}
