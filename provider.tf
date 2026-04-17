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