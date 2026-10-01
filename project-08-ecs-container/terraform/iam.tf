# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ECS TASK EXECUTION ROLE AND ATTACH APPROPRIATE AWS MANAGED POLICY
# ---------------------------------------------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_execution" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "execution" {
  name               = "${var.cluster_name}-ecs-execution"
  assume_role_policy = data.aws_iam_policy_document.assume_execution.json
}

resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

