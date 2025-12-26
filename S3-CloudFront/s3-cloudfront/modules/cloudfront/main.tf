resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled         = true
  is_ipv6_enabled = true

  # ----------------------------------------
  # オリジン設定 (コンテンツの取得元)
  # ----------------------------------------
  origin {
    # S3静的ウェブサイトのエンドポイントをオリジンとして指定
    domain_name = var.s3_website_endpoint
    origin_id   = var.s3_origin_id

    # S3ウェブサイトホスティングをオリジンとするための設定
    custom_origin_config {
      http_port  = 80
      https_port = 443
      # S3ウェブサイトホスティングはHTTPでのみアクセス可能
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # ----------------------------------------
  # デフォルトキャッシュ動作
  # ----------------------------------------
  default_cache_behavior {
    target_origin_id = var.s3_origin_id

    # 閲覧者からのアクセスはすべてHTTPSにリダイレクトする
    viewer_protocol_policy = "redirect-to-https"

    # キャッシュ可能なメソッドと許可するメソッドを設定
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # コンテンツの圧縮を有効にする (パフォーマンス向上)
    compress = true

    # クエリ文字列、クッキー、ヘッダーはオリジンに転送しない (キャッシュヒット率向上)
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # ----------------------------------------
  # ビューア証明書 (HTTPS設定)
  # ----------------------------------------
  viewer_certificate {
    # CloudFrontが提供するデフォルト証明書を無料で使用
    cloudfront_default_certificate = true
  }

  # ----------------------------------------
  # アクセス制限
  # ----------------------------------------
  restrictions {
    geo_restriction {
      # 地理的制限なし
      restriction_type = "none"
    }
  }

  # ----------------------------------------
  # タグ
  # ----------------------------------------
  tags = {
    Name = "${var.s3_origin_id}-cdn"
  }
}
