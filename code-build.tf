resource "aws_codebuild_project" "build" {
  name         = var.bucket_name
  description  = var.build_desc
  service_role = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type      = "CODEPIPELINE"
    packaging = "ZIP"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("buildspec/buildspec.yml")
  }
}
