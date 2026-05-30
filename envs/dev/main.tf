module "apis" {
  source     = "git::https://github.com/AlvaroJ1212/terraform-google-apis.git?ref=v1.0.0"
  project_id = var.project_id
  apis       = var.apis
}

module "network" {
  source      = "git::https://github.com/AlvaroJ1212/terraform-google-network.git?ref=v1.0.0"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = "vpc-dev"
  subnet_cidr = "10.0.1.0/24"

  depends_on = [module.apis]
}

module "storage" {
  source      = "git::https://github.com/AlvaroJ1212/terraform-google-storage.git?ref=v1.0.0"
  project_id  = var.project_id
  region      = var.region
  bucket_name = var.bucket_name
}

module "pubsub" {
  source            = "git::https://github.com/AlvaroJ1212/terraform-google-pubsub.git?ref=v1.0.0"
  project_id        = var.project_id
  region            = var.region
  topic_name        = "my-topic-dev"
  subscription_name = "my-subscription-dev"
}

module "repository" {
  source        = "git::https://github.com/AlvaroJ1212/terraform-google-repository.git?ref=v1.0.0"
  project_id    = var.project_id
  repository_id = var.repository_id
  region        = var.region
}

module "monitoring" {
  source                      = "git::https://github.com/AlvaroJ1212/terraform-google-monitoring.git?ref=v1.0.0"
  project_id                  = var.project_id
  bucket_name                 = module.storage.bucket_name
  topic_name                  = module.pubsub.topic_name
  dashboard_display_name      = "System Overview Dev"
  logging_metric_name         = "error_count_dev"
  logging_metric_display_name = "Error Count Dev"
}

module "iam" {
  source      = "git::https://github.com/AlvaroJ1212/terraform-google-iam.git?ref=v1.0.0"
  project_id  = var.project_id
  sa_roles    = ["roles/storage.admin", "roles/pubsub.admin"]
  bucket_name = module.storage.bucket_name
  topic_name  = module.pubsub.topic_name
}
