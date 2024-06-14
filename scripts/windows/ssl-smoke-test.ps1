#!/usr/bin/env pwsh
# Define namespace and deployment name
$namespace = "cert-manager"
$deployment_name = "cert-manager"
$resource_name="LET'S ENCRYPT:"
# Retrieve logs from the cert-manager deployment
$logs = kubectl logs -n $namespace deploy/$deployment_name

# Check if the specific rate-limited error is found
if ($logs -match "urn:ietf:params:acme:error:rateLimited") {
  Write-Host "$resource_name Error: urn:ietf:params:acme:error:rateLimited found in cert-manager logs. certificate issuer is rate limited. try again after cooldown period" -ForegroundColor Red
  # exit 1
}
else {
  Write-Host "$resource_name No rate limit error (urn:ietf:params:acme:error:rateLimited) found in cert-manager logs." -ForegroundColor Green
}
