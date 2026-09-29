################################################################################
# Cloud Watch
################################################################################

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "${local.alarms.cpu.name}-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.alarms.cpu.eval_periods
  metric_name         = local.alarms.cpu.metric
  namespace           = "AWS/EC2"
  period              = local.alarms.cpu.period
  statistic           = "Average"
  threshold           = var.cpu_threshold

  alarm_actions = [aws_sns_topic.main.arn]
  ok_actions    = [aws_sns_topic.main.arn]

  dimensions = {
    InstanceId = aws_instance.main.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-cpu-alarm"
  })

}

resource "aws_cloudwatch_metric_alarm" "alb" {
  alarm_name          = "${local.alarms.cpu.name}-alb"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.alarms.alb_5xx.eval_periods
  metric_name         = local.alarms.alb_5xx.metric
  namespace           = "AWS/ApplicationELB"
  period              = local.alarms.alb_5xx.period
  statistic           = "Average"
  threshold           = var.alb_5xx_threshold

  alarm_actions = [aws_sns_topic.main.arn]
  ok_actions    = [aws_sns_topic.main.arn]

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-alb-alarm"
  })
}