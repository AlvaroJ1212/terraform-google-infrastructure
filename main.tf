resource "google_project_service" "storage_api" {
  project            = var.project_id
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "apis" {
  for_each           = toset(var.apis)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

resource "google_pubsub_topic" "notifications" {
  project = var.project_id
  name    = "tf-alvaro-notifications"

  message_retention_duration = "86400s"
}

resource "google_pubsub_subscription" "notifications_sub" {
  project = var.project_id
  name    = "tf-alvaro-notifications-sub"
  topic   = google_pubsub_topic.notifications.id

  ack_deadline_seconds       = 60
  message_retention_duration = "604800s"

  expiration_policy {
    ttl = ""
  }
}

module "monitoring" {
  source      = "./modules/monitoring"
  project_id  = var.project_id
  bucket_name = var.bucket_name
  topic_name  = google_pubsub_topic.notifications.name
}

module "storage" {
  source      = "./modules/storage"
  project_id  = var.project_id
  region      = var.region
  bucket_name = var.bucket_name
}