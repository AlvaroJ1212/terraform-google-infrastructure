# Google Cloud Infrastructure with Terraform

This repository serves as the root Infrastructure-as-Code (IaC) project to provision a scalable, secure, and highly available environment on Google Cloud Platform (GCP). 

It demonstrates advanced Terraform patterns, including the use of **remote standalone modules**, **environment separation**, and **remote state management**.

## Architecture & Modules

Instead of a monolithic configuration, this infrastructure is composed of multiple independent, versioned modules hosted in separate repositories. This ensures reusability and safe deployments:

* **[APIs](https://github.com/AlvaroJ1212/terraform-google-apis)**: Enables required GCP services.
* **[Storage](https://github.com/AlvaroJ1212/terraform-google-storage)**: Provisions Cloud Storage buckets.
* **[Pub/Sub](https://github.com/AlvaroJ1212/terraform-google-pubsub)**: Sets up event-driven messaging topics and subscriptions.
* **[Monitoring](https://github.com/AlvaroJ1212/terraform-google-monitoring)**: Deploys custom dashboards and log-based metrics.
* **[IAM](https://github.com/AlvaroJ1212/terraform-google-iam)**: Manages secure service account bindings following the principle of least privilege.
* **[Repository](https://github.com/AlvaroJ1212/terraform-google-repository)**: Provisions Artifact Registry for container images.

## Project Structure

The project follows a multi-environment architecture:

```text
.
├── envs/
│   ├── dev/            # Development environment configuration
│   │   ├── backend.tf  # Dev state (GCS prefix)
│   │   ├── main.tf     # Dev module calls
│   │   └── terraform.tfvars # Dev-specific variables
│   └── prod/           # Production environment configuration (Future)
├── terraform.tfvars.example # Example variable definitions
└── main.tf             # Legacy/Root configuration
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0
- Google Cloud SDK (`gcloud`)
- Appropriate GCP permissions (Owner or Editor)

## Usage

1. **Authenticate to Google Cloud:**
   ```bash
   gcloud auth application-default login
   ```

2. **Navigate to your desired environment:**
   ```bash
   cd envs/dev
   ```

3. **Initialize Terraform:**
   This downloads the external modules and configures the GCS backend.
   ```bash
   terraform init
   ```

4. **Review the execution plan:**
   ```bash
   terraform plan
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply
   ```

## CI/CD Pipeline

This project includes a GitHub Actions workflow (`.github/workflows/terraform-validate.yml`) that automatically formats and validates the Terraform code on every push and pull request to the `main` branch.
