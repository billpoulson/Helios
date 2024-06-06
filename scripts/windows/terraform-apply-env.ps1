param (
  [string]$environment = ""
)

# Call the TF_VAR_Loader.ps1 script to load the environment variables based on the specified environments .env file 
.\scripts\windows\TF_VAR_Loader.ps1 -environment $environment

terraform -chdir=infra plan
