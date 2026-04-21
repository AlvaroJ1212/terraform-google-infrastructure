output "topic_id" {
  description = "The ID of the Pub/Sub topic"
  value       = google_pubsub_topic.notifications.id
}

output "topic_name" {
  description = "The name of the Pub/Sub topic"
  value       = google_pubsub_topic.notifications.name
}

output "subscription_id" {
  description = "The ID of the Pub/Sub subscription"
  value       = google_pubsub_subscription.notifications_sub.id  
}