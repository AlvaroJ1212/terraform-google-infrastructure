# Creates a Cloud Monitoring dashboard with a 2-column grid layout.
# Includes two widgets:
# 1. Bucket Operations: tracks GCS API request rate for the specified bucket.
# 2. Pub/Sub Messages: tracks message send rate for the specified topic.
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

# Defines a log-based metric that captures Cloud Function errors.
resource "google_logging_metric" "logging_metric" {
  filter = <<-EOT
resource.type= "cloud_function"
severity= "ERROR"
EOT

name = "terraform-alvaro-metric"
project = var.project_id

# EXTRACT() pulls specific field values from matching log entries
# and stores them as metric labels for filtering and grouping.
label_extractors = {
  request_id    = "EXTRACT(labels.request_id)"
  execution_id  = "EXTRACT(labels.execution_id)"
  function_name = "EXTRACT(resource.labels.function_name)"
  payload       = "EXTRACT(textPayload)"
}

value_extractor = "EXTRACT(jsonPayload.status)"

# Uses a DELTA distribution to track error occurrences over time.
metric_descriptor {
  metric_kind  = "DELTA"
  value_type   = "DISTRIBUTION"
  unit         = "1"
  display_name = "Terraform Alvaro Metric"

  labels {
    key         = "request_id"
    value_type  = "STRING"
    description = "Cloud Function request ID"
  }
  labels {
    key         = "execution_id"
    value_type  = "STRING"
    description = "Cloud Function execution ID"
  }
  labels {
    key         = "function_name"
    value_type  = "STRING"
    description = "Cloud Function name"
  }
  labels {
    key         = "payload"
    value_type  = "STRING"
    description = "Cloud Function Payload"
  }
}

# Configures linear histogram buckets for the distribution metric:
# 3 buckets of width 100, starting at offset 0 (0-100, 100-200, 200-300).
bucket_options {
  linear_buckets {
    num_finite_buckets = 3
    width              = 100
    offset             = 0
  }
}
}