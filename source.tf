resource "aws_codestarconnections_connection" "code-connection" {
  name          = "code-connection"
  provider_type = "GitHub"
}
