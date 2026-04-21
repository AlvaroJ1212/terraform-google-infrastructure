resource "google_pubsub_topic" "notifications" {
  project = var.project_id
  name    = "tf-alvaro-notifications"

  message_retention_duration = "86400s"

  message_storage_policy {
    allowed_persistence_regions = [var.region]
  # enforce_in_transit          = true
  }
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