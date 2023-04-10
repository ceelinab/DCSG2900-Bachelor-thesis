resource "aws_kms_key" "pipeline_key" {
  description = "KMS key for encrypting pipeline artifacts"
  deletion_window_in_days = 30
}