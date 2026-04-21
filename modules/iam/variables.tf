variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "sa_roles" {
  type        = list(string)
  description = "List of roles to assign to the service account"
}

variable "bucket_name" {
  type        = string
  description = "GCS bucket name for IAM binding"
}

variable "topic_name" {
  type        = string
  description = "Pub/Sub topic name for IAM binding"
}
