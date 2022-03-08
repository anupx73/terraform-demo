# provider
variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}
variable "REGION" {
  default   = "eu-west-1"
}

# s3 bucket
variable "S3_NAME" {
  default = "tud-ca1-s3"
}
variable "S3_ACL" {
  default = "public-read"
}
variable "S3_UPLOAD_FOLDER" {
  default = "uploads/"
}
variable "S3_ENV" {
  default = "Demo"
}
variable "S3_ENCRYPT" {
  default = "aws:kms"
}
