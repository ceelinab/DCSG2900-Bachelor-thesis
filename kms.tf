resource "aws_kms_key" "pipeline_key" {
  description              = "KMS key for signing pipeline artifacts"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  key_usage                = "ENCRYPT_DECRYPT"
  is_enabled               = true

  tags = {
    Name = "pipeline_key"
  }
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/pipeline-key"
  target_key_id = aws_kms_key.pipeline_key.key_id
}