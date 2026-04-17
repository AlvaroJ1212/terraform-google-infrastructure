resource "google_monitoring_dashboard" "dashboard" {
  project        = var.project_id
  dashboard_json = jsonencode({
    displayName = "Terraform-Alvaro Dashboard"
    gridLayout = {
      columns = 2
      widgets = [
        {
          title = "Bucket Operations"
          xyChart = {
            dataSets = [{
              timeSeriesQuery = {
                timeSeriesFilter = {
                  filter = "resource.type = \"gcs_bucket\" AND resource.labels.bucket_name = \"${var.bucket_name}\" AND metric.type = \"storage.googleapis.com/api/request_count\""
                  aggregation = {
                    alignmentPeriod  = "300s"
                    perSeriesAligner = "ALIGN_RATE"
                  }
                }
              }
              plotType = "LINE"
            }]
          }
        },
        {
          title = "Pub/Sub Messages"
          xyChart = {
            dataSets = [{
              timeSeriesQuery = {
                timeSeriesFilter = {
                  filter = "resource.type = \"pubsub_topic\" AND resource.labels.topic_id = \"${var.topic_name}\" AND metric.type = \"pubsub.googleapis.com/topic/send_message_operation_count\""
                  aggregation = {
                    alignmentPeriod  = "300s"
                    perSeriesAligner = "ALIGN_RATE"
                  }
                }
              }
              plotType = "LINE"
            }]
          }
        }
      ]
    }
  })
}