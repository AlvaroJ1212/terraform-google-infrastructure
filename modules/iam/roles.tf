resource "google_project_iam_member" "mi_sa" {
  for_each = toset(var.sa_roles)
  project  = var.project_id
  role     = "roles/${each.value}"
  member   = "serviceAccount:${google_service_account.service_account_one.email}"
}