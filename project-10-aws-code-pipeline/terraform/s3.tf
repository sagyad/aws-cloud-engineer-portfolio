# =============================================================================
# FILE 1: s3.tf — Artifact Bucket for CodePipeline
# =============================================================================
# CodePipeline stores source code and build artifacts in S3 between stages.
# Source stage downloads code → stores in S3 → CodeBuild reads from S3 → builds → stores output in S3

resource "aws_s3_bucket" "artifacts" {
  bucket        = "${local.name_prefix}-pipeline-artifacts"
  force_destroy = true # Allow terraform destroy even if bucket has objects

  tags = local.common_tags
}

# Block all public access — pipeline artifacts should NEVER be public
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning — keeps history of artifacts, enables rollback
resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}