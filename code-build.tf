resource "aws_codedeploy_app" "codedeploy2" {
  compute_platform = "Lambda"
  name             = "codedeploy2"
}