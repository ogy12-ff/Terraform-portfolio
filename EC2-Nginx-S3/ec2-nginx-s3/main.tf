# ネットワークモジュール（VPC、サブネット、セキュリティグループなど）を呼び出し
module "vpc" {
  source       = "./modules/network"
  service_name = var.service_name
  env          = var.env
  subnet_cidrs = {
    public  = ["10.0.1.0/24"]
    private = ["10.0.11.0/24"]
  }
}

# コンピュートモジュール（EC2インスタンス、IAMロール）を呼び出し
module "compute" {
  source            = "./modules/compute"
  service_name      = var.service_name
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_ids
  security_group_id = module.vpc.security_group_id
  bucket_name       = module.storage.bucket_name
  bucket_arn        = module.storage.bucket_arn
}

# ストレージモジュール（S3バケット）を呼び出し
module "storage" {
  source       = "./modules/storage"
  service_name = var.service_name
  env          = var.env
}
