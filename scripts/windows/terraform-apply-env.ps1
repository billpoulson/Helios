param (
  [string]$environment = ""
)

function Parse-IniFile ($fileLocation)
{
    $parsedini = @{}
    switch -regex -file $fileLocation
    {
        '^\[(.+)\]$' {
            $section = $matches[1]
            $parsedini[$section] = @{}
        }

        '^(.+)=(.*)$' {
            $name,$value = $matches[1..2]
            $parsedini[$section][$name] = $value.Trim()
        }
    }
    return $parsedini
}

# Set environment variables
[System.Environment]::SetEnvironmentVariable("TF_LOG", "trace")

.\scripts\windows\tf-var-loader.ps1 -environment $environment
# Write-Host "Resolved scripts path: $scriptsPath"
$heliosWorkspace = $(Resolve-Path -Path "./")
[System.Environment]::SetEnvironmentVariable("TF_VAR_helios_runner", $(Resolve-Path -Path "./scripts/runner.py"))
[System.Environment]::SetEnvironmentVariable("TF_VAR_helios_workspace", $(Resolve-Path -Path "./"))

$TF_VAR_helios_Environments = @("development","production","staging")

$fileLocation = Get-ChildItem -Path ./ -Filter "*.helios" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName

# Use the function
$iniContent = Parse-IniFile -fileLocation $fileLocation 
# Access a specific section
[System.Environment]::SetEnvironmentVariable("TF_VAR_deploy_environments", $iniContent['helios.environments'])

# Write all environment variables to the console
$envVars = [System.Environment]::GetEnvironmentVariables()
foreach ($envVar in $envVars.Keys) {
  Write-Output "$envVar = $($envVars[$envVar])"
}

terraform -chdir=iac\terraform init -upgrade

terraform -chdir=iac\terraform apply -auto-approve
# terraform -chdir=iac\terraform apply -auto-approve 2>&1 | Tee-Object -FilePath terraform_apply.log
