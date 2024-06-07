#!/bin/bash
envParam="$1"

# Source the loader script to ensure environment variables are available in this shell
source ./scripts/unix/TF_VAR_Loader.sh "$envParam"

# Apply terraform with the environment variables set by the loader script
terraform -chdir=iac/terraform destroy
