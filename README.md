EC2-nginx-S3
→EC2(Amazon Linux)にnginxをインストールし、Webサーバーとして運用。静的ファイルはS3バケットから読み込む。

IAM-Policy
→IAMユーザーを作り、ポリシーを割りあてる

S3-CloudFront
→CloudFrontをエッジサーバとして使い、静的ファイルをS3から読み込む

Serverless-Architecture
→Lambda+API Gateway+DynamoDBでサーバーレス構成。

VPC-Network
→VPCにAZを2つ用意し、パブリックサブネットにEC2を配置。ALBで負荷分散。RDSをプライベートサブネットに配置し、Active-Standbyで運用
