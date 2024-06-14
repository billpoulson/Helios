param (
  [string]$environment = ""
)

# Set environment variables
[System.Environment]::SetEnvironmentVariable("TF_LOG", "trace")

.\scripts\windows\tf-var-loader.ps1 -environment $environment
# Write-Host "Resolved scripts path: $scriptsPath"
[System.Environment]::SetEnvironmentVariable("TF_VAR_helios_runner", $(Resolve-Path -Path "./scripts/runner.py"))
[System.Environment]::SetEnvironmentVariable("TF_VAR_helios_workspace", $(Resolve-Path -Path "./"))

# Load TF variables

# Write all environment variables to the console
$envVars = [System.Environment]::GetEnvironmentVariables()
foreach ($envVar in $envVars.Keys) {
  Write-Output "$envVar = $($envVars[$envVar])"
}

terraform -chdir=iac\terraform init -upgrade

terraform -chdir=iac\terraform apply -auto-approve
# terraform -chdir=iac\terraform apply -auto-approve 2>&1 | Tee-Object -FilePath terraform_apply.log
