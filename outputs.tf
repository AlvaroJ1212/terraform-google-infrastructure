output "project_id" {
  description = "ID del proyecto de GCP"
  value       = var.project_id
}

output "bucket_name" {
  description = "Nombre del bucket creado"
  value       = module.storage.bucket_name
}

output "pubsub_topic" {
  description = "Nombre del topic de Pub/Sub"
  value       = module.pubsub.topic_name
}

output "apis_enabled" {
  description = "Lista de APIs habilitadas"
  value       = var.apis
}