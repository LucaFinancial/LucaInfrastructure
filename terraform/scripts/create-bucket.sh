#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the environment argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

ENV="$1"
ENV_FILE="$ENV/.env"

# Source the environment variables
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

# Set the project
gcloud config set project "$PROJECT_ID"

# Check if the bucket already exists
if gsutil ls -b "gs://$BUCKET_NAME" &>/dev/null; then
  echo "Bucket gs://$BUCKET_NAME already exists."
else
  # Create the bucket
  gsutil mb -l "$BUCKET_REGION" "gs://$BUCKET_NAME/"
  echo "Bucket gs://$BUCKET_NAME created."
fi

# Enable or disable versioning based on ENABLE_VERSIONING
if [ "$ENABLE_VERSIONING" == "true" ]; then
  gsutil versioning set on "gs://$BUCKET_NAME/"
  echo "Versioning has been enabled on gs://$BUCKET_NAME."

  # Apply the lifecycle configuration
  LIFECYCLE_CONFIG_FILE="$ENV/lifecycle-config.json"
  gsutil lifecycle set "$LIFECYCLE_CONFIG_FILE" "gs://$BUCKET_NAME/"
  echo "Lifecycle rules have been set on gs://$BUCKET_NAME."
else
  gsutil versioning set off "gs://$BUCKET_NAME/"
  echo "Versioning has been disabled on gs://$BUCKET_NAME."
fi