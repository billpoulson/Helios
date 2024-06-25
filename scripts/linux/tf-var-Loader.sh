#!/bin/bash
# Check if the environment is provided as an argument
environment="$1"
# Determine the .env file based on the environment parameter
case "$environment" in
    "" | "dev" | "development" | "local")
        filePath="./iac/.env"
    ;;
    *)
        filePath="./iac/.env.$environment"
    ;;
esac

echo "Loading environment variables from $filePath"

# Count the total number of lines in the file to determine progress
total_lines=$(grep -vc ^# "$filePath")
current_line=0

# Load the environment variables from the specified .env file
while IFS='=' read -r key value || [ -n "$key" ]; do
    # Increment the current_line counter
    current_line=$((current_line + 1))
    # Skip lines that start with #
    if [[ "$key" =~ ^#.* ]]; then
        echo "  skipped line: $key"
        continue
    fi
    # Ensure the line matches "key=value" format
    if [[ "$key" =~ ^[^=]+$ ]]; then
        # Obscure the value if its length is greater than 6
        obscuredValue="$value"
        if [ ${#value} -gt 6 ]; then
            obscuredValue="${value:0:3}$(printf '*%.0s' $(seq 1 $((${#value}-6))))${value: -3}"
        fi
        export "TF_VAR_$key"="$value"
        export "$key"="$value"
        echo "  converted key $key >>> TF_VAR_$key with value: $obscuredValue"
    fi
    # Show progress
done < "$filePath"

echo