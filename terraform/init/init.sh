#!/usr/bin/env bash

# Minimal Terraform GCS backend initialization script
# Creates GCS state bucket and generates backend.tf in current directory

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <env>" >&2
  echo "Example: $0 dev" >&2
  exit 1
fi

ENV="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/env/${ENV}.env"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "Environment file ${ENV_FILE} not found" >&2
  exit 1
fi

# Load environment variables
set -a
source "${ENV_FILE}"
set +a

# Validate required variables
: "${GCP_PROJECT?GCP_PROJECT missing in env file}"
: "${TF_STATE_BUCKET?TF_STATE_BUCKET missing in env file}"
: "${TF_STATE_PATH?TF_STATE_PATH missing in env file}"
: "${REGION?REGION missing in env file}"

echo "Initializing Terraform backend for environment: ${ENV}"
echo "Project: ${GCP_PROJECT}"
echo "Bucket: gs://${TF_STATE_BUCKET}"
echo "State path: ${TF_STATE_PATH}"

# Ensure gcloud is using the correct project
current_project=$(gcloud config get-value project 2>/dev/null || true)
if [[ "${current_project}" != "${GCP_PROJECT}" ]]; then
  echo "Setting gcloud project to ${GCP_PROJECT}"
  gcloud config set project "${GCP_PROJECT}" >/dev/null
fi

# Create state bucket if it doesn't exist
if ! gsutil ls -b "gs://${TF_STATE_BUCKET}" >/dev/null 2>&1; then
  echo "Creating Terraform state bucket: gs://${TF_STATE_BUCKET}"
  gsutil mb -p "${GCP_PROJECT}" -l "${REGION}" "gs://${TF_STATE_BUCKET}"
  
  # Enable versioning for state file safety
  echo "Enabling versioning on state bucket"
  gsutil versioning set on "gs://${TF_STATE_BUCKET}"
else
  echo "State bucket gs://${TF_STATE_BUCKET} already exists"
fi

# Generate backend.tf in current directory
BACKEND_FILE="./backend.tf"

cat > "${BACKEND_FILE}" <<EOF
terraform {
  backend "gcs" {
    bucket = "${TF_STATE_BUCKET}"
    prefix = "${TF_STATE_PATH}"
  }
}
EOF

echo "Generated ${BACKEND_FILE} in current directory"
echo ""
echo "Next steps:"
echo "1. Run 'terraform init' to initialize the backend"
echo "2. Create your main.tf and other Terraform files as needed"
echo ""
echo "Initialization complete!"