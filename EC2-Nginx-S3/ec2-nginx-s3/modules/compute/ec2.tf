# EC2インスタンス（Webサーバー）を作成
resource "aws_instance" "ec2_instance" {
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

  instance_type = "t2.micro"
  ami           = "ami-0d52744d6551d851e" #Amazon Linux 2023

  tags = {
    Name = "${var.service_name}-${var.env}-web-server"
  }

  # インスタンス起動時に実行するスクリプト（Nginxインストール、S3マウントなど）
  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                amazon-linux-extras install nginx1 -y
                yum install s3fs-fuse -y
                systemctl start nginx
                systemctl enable nginx
                mkdir -p /var/www/html/static
                s3fs ${var.bucket_name} /var/www/html/static -o iam_role=auto -o allow_other -o umask=000
                cat > /etc/nginx/conf.d/static.conf << 'EOL'
                server {
                    listen 80;
                    location /static {
                        alias /var/www/html/static/;
                        autoindex on;
                    }
                }
                EOL
                systemctl reload nginx
                echo "<h1>Welcome to ${var.service_name} in ${var.env} environment!</h1><p>Static files from S3: <a href='/static/'>/static/</a></p>" > /usr/share/nginx/html/index.html
                EOF
}
