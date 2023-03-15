resource "aws_codedeploy_app" "codedeploy" {
  compute_platform = "Lambda"
  name             = "codedeploy"
}