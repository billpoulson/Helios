# Function to check if a command is available
function Check-Command {
  param (
      [string]$command
  )
  if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
      Write-Host "$command is not installed or not in your PATH."
      exit 1
  } else {
      Write-Host "$command is available."
  }
}

# Verify the following
Check-Command "docker"
Check-Command "kubectl"
Check-Command "terraform"

Write-Host "All required commands are available."
