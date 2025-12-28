#CloudWatchアラームの作成(死活監視)
resource "aws_cloudwatch_metric_alarm" "ec2_status_check_failed" {
  alarm_name          = "${var.service_name}-${var.env}-ec2-status-check-failed"
  evaluation_periods  = "1"                             #指定の回数連続で閾値を超えた場合にアラーム発報
  comparison_operator = "GreaterThanOrEqualToThreshold" #閾値を超えた場合にアラーム発報
  metric_name         = "StatusCheckFailed"             #監視するメトリクス
  namespace           = "AWS/EC2"                       # メトリクスの名前空間
  period              = "60"                            # 60秒間隔でチェック
  statistic           = "Maximum"                       # 統計方法
  threshold           = "1"                             # 閾値
  alarm_description   = "EC2インスタンスが応答していません（停止、またはハードウェア障害）"

  # 通知先を指定
  alarm_actions = [aws_sns_topic.system_alert.arn]
  ok_actions    = [aws_sns_topic.system_alert.arn] # 復旧時も通知したい場合

  dimensions = {
    InstanceId = var.instance_id
  }
}

# Simple Nortification Serviceトピックの作成
resource "aws_sns_topic" "system_alert" {
  name = "ec2-dead-alert"
}

#メールアドレスの登録
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.system_alert.arn
  protocol  = "email"
  endpoint  = "your-email-address@example.com" # 受信したいメールアドレスに変更してください
}
