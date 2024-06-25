param (
  [string]$environment = ""
)

$defaultEnvs = @("", "dev", "local", "development")

$filePath = if ($defaultEnvs -contains $environment) {
  "/iac/.env"
}
else {
  "./iac/.env.$environment"
}

$lines = Get-Content $filePath

$totalLines = $lines.Count
$currentLine = 0

$lines | ForEach-Object {
  if ($_ -match "^(?<key>[^=]+)=(?<value>.*)$" -and $_ -notmatch "^#") {
    $value = $matches['value']
    $obscuredValue = if ($value.Length -gt 6) {
      $value.Substring(0, 3) + ('*' * ($value.Length - 6)) + $value.Substring($value.Length - 3)
    }
    else {
      $value
    }
    [System.Environment]::SetEnvironmentVariable("TF_VAR_" + $matches.key, $value)
    
    $currentLine++
    
    $percentage = ($currentLine / $totalLines) * 100
    Write-Output "  converted key $($matches.key) >>> TF_VAR_$($matches.key) with value: $obscuredValue"
  }
  elseif ($_ -match "^#") {
    Write-Output "  skipped line: $_"
  }
}

os.environ["ENV"] = args.env
os.environ["HELIOS_KUBE_CONTEXT"] = args.kube_context_name
os.environ["TF_VAR_kube_context_name"] = args.kube_context_name
os.environ["TF_VAR_app_namespace"] = "ass"
