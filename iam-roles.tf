resource "aws_iam_role" "codepipline-role" {
  name = "codepipline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "tf-cicd-pipeline-policies2" {
  statement {
    sid       = ""
    actions   = ["codestar-connections:UseConnection"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid       = ""
    actions   = ["s3:*", "codebuild:*", ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "tf-cicd-pipeline-policy2" {
  name        = "tf-cicd-pipeline-policy2"
  path        = "/"
  description = "Pipeline policy"
  policy      = data.aws_iam_policy_document.tf-cicd-pipeline-policies2.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-pipeline-attachment" {
  policy_arn = aws_iam_policy.tf-cicd-pipeline-policy2.arn
  role       = aws_iam_role.codepipline-role.id
}

resource "aws_iam_role" "tf-codebuild-role" {
  name = "tf-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "tf-cicd-build-policies" {
  statement {
    sid       = ""
    actions   = ["logs:*", "s3:*", "codebuild:*", "secretsmanager:*", "iam:*"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "tf-cicd-build-policy2" {
  name        = "tf-cicd-build-policy2"
  path        = "/"
  description = "Codebuild policy"
  policy      = data.aws_iam_policy_document.tf-cicd-build-policies.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment1" {
  policy_arn = aws_iam_policy.tf-cicd-build-policy2.arn
  role       = aws_iam_role.tf-codebuild-role.id
}

resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment2" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role       = aws_iam_role.tf-codebuild-role.id
}

resource "aws_iam_role" "codedeploy-role" {
  name = "codedeploy-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "codedeploy.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy-role-attachment1" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy-role.id
}

resource "aws_iam_role_policy_attachment" "codedeploy-role-attachment2" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.codedeploy-role.id
}

data "aws_iam_policy_document" "codedeploy-document" {
  statement {
    sid = "VisualEditor0"
    effect = "Allow"
    actions = ["codedeploy:CreateDeployment"]
    resources = [ "*" ]
  }
}

resource "aws_iam_policy" "codedeploy-create-deployment" {
  name        = "codedeploy-create-deployment"
  path        = "/"
  description = "Codedeploy policy"
  policy      = data.aws_iam_policy_document.codedeploy-document.json
}

resource "aws_iam_role_policy_attachment" "codedeploy-role-attachment3" {
  policy_arn = aws_iam_policy.codedeploy-create-deployment.arn
  role = aws_iam_role.codedeploy-role.id
}

resource "aws_iam_role_policy_attachment" "test" {
  policy_arn = aws_iam_policy.codedeploy-create-deployment.arn
  role = aws_iam_role.codepipline-role.id
}

resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy-role-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.ec2-role.id
}

#bytt navn!
data "aws_iam_policy_document" "codedeploy-document-config" {
  statement {
    sid = "VisualEditor0"
    effect = "Allow"
    actions = ["codedeploy:*"]
    resources = [ "*" ]
  }
}

resource "aws_iam_policy" "codedeploy-create-deployment-config" {
  name        = "codedeploy-create-deployment-config"
  path        = "/"
  description = "Codedeploy policy"
  policy      = data.aws_iam_policy_document.codedeploy-document-config.json
}

resource "aws_iam_role_policy_attachment" "codedeploy-role-attachment5" {
  policy_arn = aws_iam_policy.codedeploy-create-deployment-config.arn
  role = aws_iam_role.codepipline-role.id
}