output "project_id" {
  description = "GCP Project ID"
  value       = var.project_id
}

output "bucket_name" {
  description = "Created bucket name"
  value       = google_storage_bucket.my_bucket.name
}

output "bucket_url" {
  description = "Bucket URL in the GCP console"
  value       = "https://console.cloud.google.com/storage/browser/${google_storage_bucket.my_bucket.name}?project=${var.project_id}"
}

output "pubsub_topic" {
  description = "Pub/Sub topic name"
  value       = google_pubsub_topic.notifications.name
}

output "apis_enabled" {
  description = "List of enabled APIs"
  value       = [for api in google_project_service.apis : api.service]
}