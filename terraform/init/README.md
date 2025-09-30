# Terraform Backend Initialization

This directory contains a minimal initialization script for setting up Terraform GCS remote state backends.

## Overview

The init script handles:

- Google Cloud Storage (GCS) bucket creation for Terraform remote state
- GCS bucket versioning configuration
- Backend configuration file generation
- GCP project validation

## Directory Structure

```
init/
├── README.md          # This file
├── init.sh           # Main initialization script
└── env/              # Environment configuration files
    └── template.env   # Template for environment variables
```

## Prerequisites

- **Google Cloud CLI (gcloud)** installed and authenticated
- **gsutil** available (comes with gcloud)
- **GCP permissions** to create and manage Cloud Storage buckets
- **Environment file** configured for your target environment

## Environment Configuration

Create environment-specific configuration files in the `env/` directory:

```bash
cp env/template.env env/<environment>.env
```

Each environment file must contain:

| Variable          | Description                    | Example                     |
| ----------------- | ------------------------------ | --------------------------- |
| `ENV`             | Environment name               | `dev`, `staging`, `prod`    |
| `GCP_PROJECT`     | Google Cloud project ID        | `your-project-dev`          |
| `TF_STATE_BUCKET` | GCS bucket for Terraform state | `your-project-dev-tf-state` |
| `TF_STATE_PATH`   | Path prefix within the bucket  | `tf-state/dev`              |
| `REGION`          | Default GCP region             | `us-central1`               |

## Usage

Run the script from the directory where you want to set up Terraform:

```bash
# From your terraform environment directory
cd /path/to/terraform/your-env
../init/init.sh <environment>
```

**Example:**

```bash
cd terraform/dev-backup
../init/init.sh dev
```

## What the Script Does

1. **Validates environment file** and loads configuration
2. **Sets GCP project** context
3. **Creates GCS state bucket** (if it doesn't exist)
4. **Enables bucket versioning** for state file safety
5. **Generates backend.tf** in the current directory

## Generated Files

The script creates a single file in your current directory:

### backend.tf

```hcl
terraform {
  backend "gcs" {
    bucket = "your-tf-state-bucket"
    prefix = "tf-state/your-env"
  }
}
```

## Error Handling

The script includes:

- Strict error handling (exits on any failure)
- Required variable validation
- Safe handling of existing buckets

## Next Steps

After running the initialization:

1. **Initialize Terraform**:

   ```bash
   terraform init
   ```

2. **Create your Terraform files** (`main.tf`, `variables.tf`, etc.) as needed

3. **Plan and apply** your infrastructure:
   ```bash
   terraform plan
   terraform apply
   ```

## Troubleshooting

Common issues:

- **Permission Denied**: Check `gcloud auth list` and project permissions
- **Project Not Found**: Verify project ID in environment file
- **Environment File Missing**: Ensure the `.env` file exists in `env/` directory
