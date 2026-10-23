# =============================================================================
# FILE 2: codebuild.tf — Build Docker Image and Push to ECR
# =============================================================================
# CodeBuild = the "builder". It:
#   1. Pulls source code from S3 (put there by CodePipeline)
#   2. Runs your buildspec.yml (docker build, docker push)
#   3. Pushes Docker image to ECR
#   4. Outputs artifacts back to S3 for the next pipeline stage

resource "aws_codebuild_project" "main" {
  name          = "${local.name_prefix}-build"
  description   = "Build Docker image and push to ECR"
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = 15 # Minutes — kill build if it takes longer than 15 min

  # Where build artifacts go (CODEPIPELINE = let pipeline manage it)
  artifacts {
    type = "CODEPIPELINE"
  }

  # Build environment — the "machine" that runs your build
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"                           # 3 GB memory, 2 vCPU — enough for Docker builds
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0" # Pre-installed Docker
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true # REQUIRED for Docker builds (docker-in-docker)
    image_pull_credentials_type = "CODEBUILD"

    # Environment variables available inside buildspec.yml
    environment_variable {
      name  = "ECR_REPO_URL"
      value = aws_ecr_repository.app.repository_url
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "CONTAINER_NAME"
      value = "app"
    }
  }

  # Source — CodePipeline feeds the source code
  source {
    type      = "CODEPIPELINE"
    buildspec = "project-10-aws-code-pipeline/buildspec.yml" # Looks for this file in your repo root
  }

  # Build logs go to CloudWatch for debugging
  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/${local.name_prefix}"
      stream_name = "build-log"
    }
  }

  tags = local.common_tags
}

# Log group for CodeBuild logs
resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/codebuild/${local.name_prefix}"
  retention_in_days = 14

  tags = local.common_tags
}
