# APIs must be enabled before any other resource can be created,
# but we rely on implicit GCP behavior rather than explicit depends on
# because most resources will retry until the API is active.
module "apis" {
  source     = "./modules/apis"
  project_id = var.project_id
  apis       = var.apis
}


# Monitoring depends on storage and pubsub outputs
# to build dashboard filters for the correct bucket and topic.
module "monitoring" {
  source      = "./modules/monitoring"
  project_id  = var.project_id
  bucket_name = var.bucket_name
  topic_name  = module.pubsub.topic_name
}



module "storage" {
  source      = "./modules/storage"
  project_id  = var.project_id
  region      = var.region
  bucket_name = var.bucket_name
}

module "pubsub" {
  source     = "./modules/pubsub"
  project_id = var.project_id
  region     = var.region
}

module "repository" {
  source     = "./modules/repository"
  project_id = var.project_id
  region     = var.region
}

# IAM bindings reference storage and pubsub outputs,
# so Terraform will create those resources first automatically.
module "iam" {
  source      = "./modules/iam"
  project_id  = var.project_id
  sa_roles    = ["storage.admin", "pubsub.admin"]
  bucket_name = module.storage.bucket_name
  topic_name  = module.pubsub.topic_name
}