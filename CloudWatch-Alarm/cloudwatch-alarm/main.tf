module "network" {
  source       = "./modules/network"
  service_name = var.service_name
  env          = var.env
}

module "compute" {
  source           = "./modules/compute"
  service_name     = var.service_name
  env              = var.env
  public_subnet_id = module.network.public_subnet_id
}

module "alert" {
  source       = "./modules/alert"
  service_name = var.service_name
  env          = var.env
  instance_id  = module.compute.instance_id
}
