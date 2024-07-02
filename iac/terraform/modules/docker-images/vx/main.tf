locals {
  hash_lookup    = "${var.helios_workspace}/scripts/linux/lookup-exhelion-hash"
  hash_file_path = "${var.helios_workspace}/helios.hash.json"
}
data "external" "lookup-exhelion-hash" {
  program     = ["bash", local.hash_lookup, var.docker_context, local.hash_file_path ]
}
output "value" {
  value = data.external.lookup-exhelion-hash.result.value
}
