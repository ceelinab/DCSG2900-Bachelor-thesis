resource "aws_s3_bucket" "codepipline_artifact" {
  bucket = var.bucket_name
}