#!/bin/bash
envParam="$1"

# Source the loader script to ensure environment variables are available in this shell
source ./scripts/unix/tf-var-loader.sh "$envParam"

# Apply terraform with the environment variables set by the loader script
terraform -chdir=iac/terraform init -upgrade

terraform -chdir=iac/terraform apply -auto-approve 
