param (
  [string]$environment = ""
)

[System.Environment]::SetEnvironmentVariable("TF_LOG", "DEBUG")

.\scripts\windows\TF_VAR_Loader.ps1 -environment $environment

terraform -chdir=iac\terraform destroy
