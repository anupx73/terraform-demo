# ITInfra CA1 by x00193210 (Anupam Saha)
# This script will provision the following on aws public cloud:
#   - s3 bucket to store user data used by app

resource "aws_s3_bucket" "this" {
  bucket                            = var.S3_NAME
  tags = {
    Name                            = "${var.S3_NAME}_tag"
    Environment                     = var.S3_ENV
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket                            = aws_s3_bucket.this.id
  acl                               = var.S3_ACL
}

resource "aws_s3_object" "this" {
  for_each                          = fileset(var.S3_UPLOAD_FOLDER, "*")
  bucket                            = aws_s3_bucket.this.id
  key                               = each.value
  source                            = "${var.S3_UPLOAD_FOLDER}${each.value}"
  server_side_encryption            = var.S3_ENCRYPT
}
