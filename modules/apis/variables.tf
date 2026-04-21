variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "apis" {
  type        = list(string)
  description = "List of GCP APIs to enable"
}