resource "aws_kms_key" "pipeline_key" {
  description = "KMS key for signing pipeline artifacts"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled               = true

  tags = {
    Name = "pipeline_key"
  }
}