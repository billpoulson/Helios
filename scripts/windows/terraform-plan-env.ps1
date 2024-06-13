param (
  [string]$environment = ""
)

[System.Environment]::SetEnvironmentVariable("TF_LOG", "DEBUG")

.\scripts\windows\tf-var-loader.ps1 -environment $environment

terraform -chdir=iac\terraform plan
