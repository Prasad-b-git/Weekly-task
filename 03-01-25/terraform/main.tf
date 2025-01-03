provider "aws" {
  region = "ap-south-1"
}
locals {
  environment = "dev"
  region      = "ap-south-1"
}
module "networking" {
  source = "./modules/networking"
  
  environment           = local.environment
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["${local.region}a", "${local.region}b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

# In root main.tf, update the compute module:
module "compute" {
  source            = "./modules/compute"
  environment       = local.environment
  ami_id            = "ami-053b12d3152c0cc71"
  instance_type     = "t2.micro"
  key_name          = "terraform"          # Updated to match your existing key pair name
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  public_sg_id      = module.security.public_sg_id
  private_sg_id     = module.security.private_sg_id
}
module "loadbalancer" {
  source            = "./modules/loadbalancer"
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  public_sg_id      = module.security.public_sg_id
  instance_id       = module.compute.public_instance_id
  environment       = local.environment
}
