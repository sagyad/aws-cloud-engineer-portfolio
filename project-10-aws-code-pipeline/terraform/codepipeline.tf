# =============================================================================
# FILE 3: codepipeline.tf — The Orchestrator (Source → Build → Deploy)
# =============================================================================
# CodePipeline = the "conductor". It orchestrates the entire CI/CD flow:
#   Stage 1 (Source):  Pull code from GitHub → store in S3
#   Stage 2 (Build):   CodeBuild builds Docker image → push to ECR
#   Stage 3 (Deploy):  Update ECS service with new image

resource "aws_codepipeline" "main" {
  name     = "${local.name_prefix}-pipeline"
  role_arn = aws_iam_role.codepipeline.arn

  # Pipeline artifacts stored in S3
  artifact_store {
    location = aws_s3_bucket.artifacts.id
    type     = "S3"
  }

  # Stage 1: SOURCE — Pull code from GitHub
  # When you push to main branch → pipeline triggers automatically
  stage {
    name = "Source"

    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn # GitHub connection (created in console)
        FullRepositoryId = var.github_repo             # e.g., "your-username/your-repo"
        BranchName       = var.github_branch           # e.g., "main"
      }
    }
  }

  # Stage 2: BUILD — CodeBuild builds Docker image, pushes to ECR
  stage {
    name = "Build"

    action {
      name             = "Docker_Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.main.name
      }
    }
  }

  # Stage 3: DEPLOY — Update ECS service with new Docker image
  stage {
    name = "Deploy"

    action {
      name            = "Deploy_to_ECS"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = aws_ecs_cluster.main.name
        ServiceName = aws_ecs_service.main.name
        FileName    = "imagedefinitions.json" # CodeBuild creates this file — tells ECS which image to use
      }
    }
  }

  tags = local.common_tags
}