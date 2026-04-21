resource "google_artifact_registry_repository" "tf_alvaro_repo" {
  project       = var.project_id
  location      = var.region
  repository_id = "my-repository"
  description   = "Docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}