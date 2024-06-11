param (
  [string]$environment = ""
)

$defaultEnvs = @("", "dev", "local", "development")

$filePath = if ($defaultEnvs -contains $environment) {
  ".env"
}
else {
  ".env.$environment"
}

$lines = Get-Content $filePath

$totalLines = $lines.Count
$currentLine = 0

function Show-ProgressBar {
  param (
    [int]$Percentage
  )
  $totalBlocks = 30
  $filledBlocks = [math]::Round($Percentage / 100 * $totalBlocks)
  $emptyBlocks = $totalBlocks - $filledBlocks
  $progressBar = ("#" * $filledBlocks) + ("-" * $emptyBlocks)
  Write-Progress -Activity "Progress" -Status "$Percentage% complete" -PercentComplete $Percentage
  Write-Host "[$progressBar] $Percentage% complete"
}
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
