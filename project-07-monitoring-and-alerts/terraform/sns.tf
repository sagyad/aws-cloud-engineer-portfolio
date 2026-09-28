################################################################################
# SNS Topic
################################################################################


resource "aws_sns_topic" "main" {
  name = "${local.name_prefix}-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}