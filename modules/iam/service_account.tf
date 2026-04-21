resource "google_service_account" "service_account_one" {
  project      = var.project_id
  account_id   = "service-account-one"
  display_name = "Service Account One"
}