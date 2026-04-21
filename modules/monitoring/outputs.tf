output "dashboard_id" {
  description = "Created dashboard ID"
  value       = google_monitoring_dashboard.dashboard.id
}

output "logging_metric_id" {
  description = "Created logging metric ID"
  value       = google_logging_metric.logging_metric.id
}