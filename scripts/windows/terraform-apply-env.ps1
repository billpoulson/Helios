param (
  [string]$environment = ""
)

[System.Environment]::SetEnvironmentVariable("TF_LOG", "TRACE")

.\scripts\windows\tf-var-loader.ps1 -environment $environment

terraform -chdir=iac\terraform init -upgrade

terraform -chdir=iac\terraform apply -auto-approve
# terraform -chdir=iac\terraform apply -auto-approve 2>&1 | Tee-Object -FilePath terraform_apply.log
