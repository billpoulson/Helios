param (
  [string]$environment = ""
)

# Set Terraform log level to DEBUG
[System.Environment]::SetEnvironmentVariable("TF_LOG", "DEBUG")

# Load environment-specific variables
.\scripts\windows\tf-var-loader.ps1 -environment $environment

# Delete Terraform state files and directory
Remove-Item -Path "./iac/terraform/.terraform" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "./iac/terraform/.terraform.lock.hcl" -ErrorAction SilentlyContinue
Remove-Item -Path "./iac/terraform/terraform.tfstate" -ErrorAction SilentlyContinue
Remove-Item -Path "./iac/terraform/terraform.tfstate.backup" -ErrorAction SilentlyContinue

