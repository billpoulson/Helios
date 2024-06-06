#!/bin/bash

# Function to check if a command is available
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed or not in your PATH."
        exit 1
    else
        echo "$1 is available."
    fi
}
# Verify the following
check_command "docker"
check_command "kubectl"
check_command "terraform"

echo "All required commands are available."
