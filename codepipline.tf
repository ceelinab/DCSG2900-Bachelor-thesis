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
        ProjectName = "build2"
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
        ApplicationName     = aws_codedeploy_app.codedeploy.name
        DeploymentGroupName = var.deploy_group_name
      }
    }
  }
}