# Octonomy Terraform Deployments

This repository contains IAC code and GitHub Actions workflows for deploying infrastructure using Terraform across multiple environments.

## Workflows

### 1. Terraform Apply (Main Infrastructure)
**File:** `.github/workflows/terraform-apply.yml`

Deploys the main application infrastructure including API, database, scheduler, and various services.

**Trigger:** Manual dispatch
**Environments:** dev, test, stage, prod

#### Features:

- Different service deployments based on environment:
  - **Dev:** Includes `librarian` service
  - **Test:** Standard service set
  - **Stage/Prod:** Additional `whg-api` and `whg-agent-runtime` services

### 2. Terraform Apply ETL
**File:** `.github/workflows/terraform-apply-etl.yml`

Deploys ETL (Extract, Transform, Load) infrastructure separately from the main application.

**Trigger:** Manual dispatch
**Environments:** dev, test, stage, prod

## Prerequisites

### GitHub Secrets Required:
- `AWS_ACCESS_KEY_ID` - AWS access key for authentication
- `AWS_SECRET_ACCESS_KEY` - AWS secret key for authentication

### GitHub Variables Required:
- `KEY` - Backend configuration key for main Terraform state
- `KEY_ETL` - Backend configuration key for ETL Terraform state

## Directory Structure
```
.
├── appcompute/          # Main application Terraform configuration
│   ├── dev.tfvars
│   ├── test.tfvars
│   ├── stage.tfvars
│   └── prod.tfvars
└── etl/                 # ETL Terraform configuration
    ├── dev.tfvars
    ├── test.tfvars
    ├── stage.tfvars
    └── prod.tfvars
```

## Usage

### Deploy Main Infrastructure
1. Go to **Actions** tab in GitHub
2. Select **Terraform Apply** workflow
3. Click **Run workflow**
4. Choose your target environment (dev/test/stage/prod)
5. Click **Run workflow**

### Deploy ETL Infrastructure
1. Go to **Actions** tab in GitHub
2. Select **Terraform Apply ETL** workflow
3. Click **Run workflow**
4. Choose your target environment (dev/test/stage/prod)
5. Click **Run workflow**

## AWS Configuration
- **Region:** eu-central-1
- **Terraform Version:** 1.9.1
- **Backend:** S3 (configured via backend-config keys)

## Notes
- All deployments use `--auto-approve` flag for automated execution
- Environment-specific variable files (`.tfvars`) are used for each deployment
