resource "google_storage_bucket_iam_member" "sa_bucket" {
  bucket = var.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.service_account_one.email}"
}

resource "google_pubsub_topic_iam_member" "sa_topic" {
  project = var.project_id
  topic   = var.topic_name
  role    = "roles/pubsub.editor"
  member  = "serviceAccount:${google_service_account.service_account_one.email}"
}