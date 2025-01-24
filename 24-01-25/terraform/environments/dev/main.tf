module "vpc" {
  source = "../../modules/vpc"

  environment          = "dev"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "ec2" {
  source = "../../modules/ec2"

  environment    = "dev"
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.private_subnet_ids[0]
  vpc_id         = module.vpc.vpc_id
