param (
  [string]$environment = ""
)

function Parse-IniFile ($fileLocation) {
  $parsedini = @{}
  switch -regex -file $fileLocation {
    '^\[(.+)\]$' {
      $section = $matches[1]
      $parsedini[$section] = @{}
    }

    '^(.+)=(.*)$' {
      $name, $value = $matches[1..2]
      $parsedini[$section][$name] = $value.Trim()
    }
  }
  return $parsedini
}

[System.Environment]::SetEnvironmentVariable("TF_LOG", "DEBUG")

# .\scripts\windows\tf-var-loader.ps1 -environment $environment
# Write-Host "Resolved scripts path: $scriptsPath"
[System.Environment]::SetEnvironmentVariable("TF_VAR_helios_runner", $(Resolve-Path -Path "./scripts/runner.py"))
[System.Environment]::SetEnvironmentVariable("TF_VAR_helios_workspace", $(Resolve-Path -Path "./"))

$fileLocation = Get-ChildItem -Path ./ -Filter "*.helios" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName

# Use the function
$iniContent = Parse-IniFile -fileLocation $fileLocation 
# Access a specific section
[System.Environment]::SetEnvironmentVariable("TF_VAR_deploy_environments", $iniContent['helios.environments'])

terraform -chdir=iac\terraform plan
