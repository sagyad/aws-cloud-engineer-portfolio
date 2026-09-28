################################################################################
# Dashboard
################################################################################

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${local.name_prefix}-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              aws_instance.main.id
            ]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "${local.name_prefix}-CPU"
        }
      },
      {
        type   = "text"
        x      = 0
        y      = 6
        width  = 3
        height = 3

        properties = {
          markdown = "${local.name_prefix}-ALB-CPU"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_ELB_5XX_Count",
              "LoadBalancer",
              aws_lb.main.arn_suffix
            ]
          ]
          period = 300
          stat   = "Sum"
          region = var.aws_region
          title  = "${local.name_prefix}-ALB-5xx"
        }
      }
    ]
  })
}