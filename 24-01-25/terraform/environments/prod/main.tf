module "vpc" {
  source = "../../modules/vpc"

  environment          = "prod"
  vpc_cidr            = "172.16.0.0/16"
  public_subnet_cidrs  = ["172.16.1.0/24", "172.16.2.0/24"]
  private_subnet_cidrs = ["172.16.3.0/24", "172.16.4.0/24"]
}

module "ec2" {
  source = "../../modules/ec2"

  environment    = "prod"
  instance_type  = "t2.small"
  subnet_id      = module.vpc.private_subnet_ids[0]
  vpc_id         = module.vpc.vpc_id
}
