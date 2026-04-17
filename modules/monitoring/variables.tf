variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "bucket_name" {
  description = "Name of the bucket to monitor"
  type        = string
}

variable "topic_name" {
  description = "Name of the Pub/Sub topic to monitor"
  type        = string
}