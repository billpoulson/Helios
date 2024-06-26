#!/bin/bash

# Define namespace and deployment name
namespace="cert-manager"
deployment_name="cert-manager"

# Retrieve logs from the cert-manager deployment
logs=$(kubectl logs -n "$namespace" deploy/"$deployment_name")

# Check if the specific rate-limited error is found
if echo "$logs" | grep -q "urn:ietf:params:acme:error:rateLimited"; then
    echo "Error: urn:ietf:params:acme:error:rateLimited found in cert-manager logs."
    exit 1
else
    echo "No rate limit error (urn:ietf:params:acme:error:rateLimited) found in cert-manager logs."
fi
