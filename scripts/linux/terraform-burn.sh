#!/bin/bash

envParam="$1"
# Set Terraform log level to DEBUG
export TF_LOG=DEBUG

# Load environment-specific variables
source ./scripts/unix/tf-var-loader.sh -e "$environment"

# Delete Terraform state files and directory
rm -rf ./iac/terraform/.terraform
rm -f ./iac/terraform/.terraform.lock.hcl
rm -f ./iac/terraform/terraform.tfstate
rm -f ./iac/terraform/terraform.tfstate.backup
