# Terraform Initialization

This directory contains scripts and configuration files for initializing Terraform remote state backends using Google Cloud Storage (GCS).

## Overview

The initialization process sets up a GCS bucket to store Terraform state files remotely, enabling team collaboration and state locking. The `init.sh` script automates this process and generates the necessary backend configuration.

## Files

- `init.sh` - Main initialization script
- `env/` - Directory containing environment-specific configuration files
  - `template.env` - Template file for creating new environment configurations

## Usage

### 1. Configure Environment

First, ensure your environment configuration file exists in the `env/` directory. You can use the template to create a new environment:

```bash
cp env/template.env env/your-env.env
```

Edit the environment file with your specific values:

```bash
ENV=your-env
GCP_PROJECT=your-gcp-project-id
TF_STATE_BUCKET=your-tf-state-bucket-name
TF_STATE_PATH=tf-state/your-env
REGION=us-central1
```

### 2. Run the Initialization Script

Navigate to the directory where you want to initialize Terraform (typically your environment-specific directory) and run:

```bash
/path/to/terraform/init/init.sh <environment>
```

Example:

```bash
# From your terraform environment directory (e.g., terraform/dev/)
../init/init.sh dev
```

### 3. What the Script Does

The `init.sh` script performs the following actions:

1. **Validates input** - Ensures an environment name is provided
2. **Loads configuration** - Reads the corresponding `.env` file from the `env/` directory
3. **Validates required variables** - Checks that all necessary environment variables are set
4. **Sets GCP project** - Configures gcloud to use the correct project
5. **Creates GCS bucket** - Creates the Terraform state bucket if it doesn't exist
6. **Enables versioning** - Turns on versioning for the state bucket for safety
7. **Generates backend.tf** - Creates a `backend.tf` file in the current directory

### 4. Complete Terraform Initialization

After running the script, complete the Terraform setup:

```bash
terraform init
```

## Environment Variables

Each environment configuration file must contain the following variables:

| Variable          | Description                       | Example                   |
| ----------------- | --------------------------------- | ------------------------- |
| `ENV`             | Environment name                  | `dev`                     |
| `GCP_PROJECT`     | GCP project ID                    | `my-project-dev`          |
| `TF_STATE_BUCKET` | GCS bucket name for state storage | `my-project-dev-tf-state` |
| `TF_STATE_PATH`   | Path prefix within the bucket     | `tf-state/dev`            |
| `REGION`          | GCP region for the bucket         | `us-central1`             |

## Prerequisites

Before running the initialization script, ensure you have:

1. **Google Cloud SDK** installed and configured
2. **Terraform** installed
3. **Appropriate GCP permissions** to:
   - Create GCS buckets
   - Manage bucket versioning
   - Read/write to the state bucket

## Generated Files

The script creates a `backend.tf` file in your current directory with the following structure:

```hcl
terraform {
  backend "gcs" {
    bucket = "your-tf-state-bucket"
    prefix = "tf-state/your-env"
  }
}
```

## Safety Features

- **Bucket versioning** is automatically enabled on the state bucket
- **Script validation** ensures all required variables are present
- **Idempotent operation** - safe to run multiple times
- **Error handling** with `set -euo pipefail` for early failure detection

## Example Workflow

```bash
# 1. Navigate to your terraform environment directory
cd terraform/dev/

# 2. Run the initialization script
../init/init.sh dev

# 3. Initialize Terraform with the new backend
terraform init

# 4. Proceed with your Terraform configuration
terraform plan
terraform apply
```

## Troubleshooting

### Common Issues

1. **Environment file not found**

   - Ensure the `.env` file exists in the `env/` directory
   - Check the filename matches the environment parameter

2. **Missing GCP permissions**

   - Verify your gcloud authentication: `gcloud auth list`
   - Ensure your account has Storage Admin permissions

3. **Bucket already exists in different project**
   - GCS bucket names are globally unique
   - Choose a different bucket name in your environment configuration

### Error Messages

- `Environment file not found` - The specified environment configuration doesn't exist
- `GCP_PROJECT missing in env file` - Required variable not set in environment file
- `Bucket creation failed` - Check GCP permissions and project settings
