################################################################################
# Outputs
################################################################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "ec2_public_ip" {
  description = "EC2 instance public ip"
  value       = aws_instance.main.public_ip
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.main.dns_name
}

output "sns_topic_name" {
  description = "SNS topic ARN for alarm notification"
  value       = aws_sns_topic.main.arn
}

output "cpu_alarm_arn" {
  description = "CPU alarm ARN"
  value       = aws_cloudwatch_metric_alarm.cpu.arn
}

output "alb_alarm_arn" {
  description = "ALB 5xx alarm ARN"
  value       = aws_cloudwatch_metric_alarm.alb.arn
}

output "dashboard_arn" {
  description = "CloudWatch dashboard ARN"
  value       = aws_cloudwatch_dashboard.main.dashboard_arn
}