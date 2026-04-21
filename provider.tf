# Pin the provider version to avoid breaking changes on upgrade.
# Credentials loaded from a local key file — in production,
# prefer Workload Identity Federation or GOOGLE_APPLICATION_CREDENTIALS env var.
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.3.0"
    }
  }
}

provider "google" {
  credentials = file("my-gcp-key.json")
  project     = var.project_id
  region      = var.region
}