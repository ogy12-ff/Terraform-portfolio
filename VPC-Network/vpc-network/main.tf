module "vpc" {
  source       = "./modules/network"
  service_name = var.service_name
  env          = var.env
  subnet_cidrs = {
    public  = ["10.0.1.0/24", "10.0.2.0/24"]
    private = ["10.0.11.0/24", "10.0.12.0/24"]
  }
}

module "db" {
  source             = "./modules/database"
  service_name       = var.service_name
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "ec2_instance" {
  source            = "./modules/compute"
  service_name      = var.service_name
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_group_arn  = module.vpc.target_group_arn
}
