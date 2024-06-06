param (
  [string]$environment = ""
)

[System.Environment]::SetEnvironmentVariable("TF_LOG", "DEBUG")

.\scripts\windows\TF_VAR_Loader.ps1 -environment $environment

terraform -chdir=infra init -upgrade

terraform -chdir=infra apply -auto-approve 
