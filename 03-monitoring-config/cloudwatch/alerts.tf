provider "aws" {
  region = "ap-south-1"
}

# Look up the EC2 instance automatically by tag
data "aws_instance" "web" {
  filter {
    name   = "tag:Name"
    values = ["devops-project-server"]
  }
}

# SNS Topic — the notification channel
resource "aws_sns_topic" "alerts" {
  name = "devops-alerts"
}

# SNS Subscription — your email gets added to the notification channel
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "ashwantnandan118@gmail.com"
}

# CloudWatch Alarm — watches CPU usage
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Triggered when CPU exceeds 80% for 2 periods"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = data.aws_instance.web.id
  }
}

# Output the SNS topic ARN
output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
