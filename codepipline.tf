resource "aws_codebuild_project" "build" {
  name         = var.build_name
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




resource "aws_codepipeline" "cicd_pipeline" {

  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipline-role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipline_artifact.bucket
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.code-connection.arn
        FullRepositoryId = var.git_repo
        BranchName       = var.git_branch
      }
    }
  }

  stage {
    name = "Plan"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "build"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ApplicationName     = aws_codedeploy_app.codedeploy2.name
        DeploymentGroupName = "deploy_group1"
      }
    }
  }
}