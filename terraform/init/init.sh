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
: "${TF_STATE_PATH?TF_STATE_PATH missing in env file}"
: "${REGION?REGION missing in env file}"

TEMPLATE_DIR="${SCRIPT_DIR}/templates"
ENV_DIR="${SCRIPT_DIR}/../${ENV}"
cp -r "${TEMPLATE_DIR}" "${ENV_DIR}"
echo "Created environment directory: ${ENV_DIR}"

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
    
    # Set lifecycle config if file exists
    LIFECYCLE_FILE="${SCRIPT_DIR}/lifecycle-config.json"
    if [[ -f "${LIFECYCLE_FILE}" ]]; then
      echo "Setting lifecycle config from ${LIFECYCLE_FILE}"
      gsutil lifecycle set "${LIFECYCLE_FILE}" "gs://${TF_STATE_BUCKET}"
    else
      echo "WARNING: ${LIFECYCLE_FILE} not found; skipping lifecycle config"
    fi
  fi
else
  echo "Bucket gs://${TF_STATE_BUCKET} already exists"
fi

TFVARS_FILE="${ENV_DIR}/terraform.tfvars"

cat > "${TFVARS_FILE}" <<EOF
env          = "${ENV}"
project_id   = "${GCP_PROJECT}"
region       = "${REGION}"

network_name    = "${GCP_PROJECT}-vpc-network"
subnet_name     = "${GCP_PROJECT}-subnet"
subnet_ip       = "10.0.0.0/24"

db_instance_name      = "${GCP_PROJECT}-sql"
db_version            = "POSTGRES_16"
db_name               = "ledger"
deletion_protection   = false

db_admin_username     = "pg-admin"
db_admin_password     = ""

db_user_username      = "pg-user"
db_user_password      = ""

authorized_networks   = []
EOF

echo "Wrote ${TFVARS_FILE} with bucket_name, project_id, and region variables"

# Generate backend.tf for remote state
BACKEND_FILE="${ENV_DIR}/backend.tf"

cat > "${BACKEND_FILE}" <<EOF
terraform {
  backend "gcs" {
    bucket = "${TF_STATE_BUCKET}"
    prefix = "${TF_STATE_PATH}"
  }
}
EOF

echo "Wrote ${BACKEND_FILE} configuring the GCS backend"

echo "Init completed: files written to ${ENV_DIR}"