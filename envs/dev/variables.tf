variable "project_id" { type = string }
variable "region" {
  type    = string
  default = "europe-west3"
}
variable "apis" {
  type    = list(string)
  default = []
}
variable "bucket_name" { type = string }
