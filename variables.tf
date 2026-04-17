variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "GCP region where resources will be created"
  type        = string
  default     = "europe-west3"
}

variable "apis" {
  description = "List of Google Cloud APIs to enable"
  type        = list(string)
  default     = []
}

variable "bucket_name" {
  description = "Bucket name (must be globally unique in Google Cloud)"
  type        = string
}