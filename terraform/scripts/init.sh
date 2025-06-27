#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the environment argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <environment>"
  echo "Example: $0 dev"
  exit 1
fi

ENV="$1"

# Define environment directory

# Check if the environment directory exists
if [ ! -d "$ENV" ]; then
  echo "Error: Environment directory '$ENV' does not exist."
  exit 1
fi

# Source the environment variables
ENV_FILE="$ENV/.env"
if [ ! -f "$ENV_FILE" ]; then
  echo "Error: Environment file '$ENV_FILE' does not exist."
  exit 1
fi
source "$ENV_FILE"

# Validate required variables in .env
REQUIRED_VARS=("PROJECT_ID" "BUCKET_NAME" "BUCKET_REGION" "ENABLE_VERSIONING")
for VAR in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!VAR}" ]; then
    echo "Error: $VAR is not set in $ENV_FILE."
    exit 1
  fi
done

# Check if required files exist
LIFECYCLE_CONFIG_FILE="$ENV/lifecycle-config.json"
if [ "$ENABLE_VERSIONING" == "true" ] && [ ! -f "$LIFECYCLE_CONFIG_FILE" ]; then
  echo "Error: Lifecycle configuration file '$LIFECYCLE_CONFIG_FILE' does not exist."
  exit 1
fi

VARIABLES_TFVARS="$ENV/terraform.tfvars"
if [ ! -f "$VARIABLES_TFVARS" ]; then
  echo "Error: Variables file '$VARIABLES_TFVARS' does not exist."
  exit 1
fi

# Create the Terraform state bucket
./scripts/create-bucket.sh "$ENV"

echo "Project initialization for environment '$ENV' completed successfully."