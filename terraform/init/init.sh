#!/usr/bin/env bash

# Strict mode
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <env>" >&2
  exit 1
fi

ENV="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/env/${ENV}.env"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "Environment file ${ENV_FILE} not found" >&2
  exit 1
fi

# Load vars from env file
set -a
source "${ENV_FILE}"
set +a

# Validate required vars
: "${GCP_PROJECT?GCP_PROJECT missing in env file}"
: "${TF_STATE_BUCKET?TF_STATE_BUCKET missing in env file}"
: "${REGION?REGION missing in env file}"

# Ensure gcloud is using the correct project
current_project=$(gcloud config get-value project 2>/dev/null || true)
if [[ "${current_project}" != "${GCP_PROJECT}" ]]; then
  gcloud config set project "${GCP_PROJECT}" >/dev/null
fi

# Create bucket if it does not exist
if ! gsutil ls -b "gs://${TF_STATE_BUCKET}" >/dev/null 2>&1; then
  echo "Creating bucket gs://${TF_STATE_BUCKET} in project ${GCP_PROJECT}"
  gsutil mb -p "${GCP_PROJECT}" -l "${REGION}" "gs://${TF_STATE_BUCKET}"
  if [[ "${ENABLE_VERSIONING:-false}" == "true" ]]; then
    gsutil versioning set on "gs://${TF_STATE_BUCKET}"
  fi
else
  echo "Bucket gs://${TF_STATE_BUCKET} already exists"
fi

# Generate terraform.tfvars at repo root
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TF_DIR="${REPO_ROOT}/terraform"
mkdir -p "${TF_DIR}"

TFVARS_FILE="${TF_DIR}/terraform.tfvars"

cat > "${TFVARS_FILE}" <<EOF
bucket_name = "${TF_STATE_BUCKET}"
project_id  = "${GCP_PROJECT}"
region      = "${REGION}"
EOF

echo "Wrote ${TFVARS_FILE} with bucket_name, project_id, and region variables"

# Generate backend.tf for remote state
BACKEND_FILE="${TF_DIR}/backend.tf"

cat > "${BACKEND_FILE}" <<EOF
terraform {
  backend "gcs" {
    bucket = "${TF_STATE_BUCKET}"
    prefix = "terraform/state"
  }
}
EOF

echo "Wrote ${BACKEND_FILE} configuring the GCS backend"

echo "Init completed: files written to ${TF_DIR}"