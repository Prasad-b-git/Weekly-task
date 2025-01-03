resource "aws_instance" "public_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[0]  # Using first public subnet
  key_name      = var.key_name
  vpc_security_group_ids = [var.public_sg_id]

  tags = {
    Name        = "${var.environment}-public-instance"
    Environment = var.environment
  }
}

resource "aws_instance" "private_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[0]  # Using first private subnet
  key_name      = var.key_name
  vpc_security_group_ids = [var.private_sg_id]

  tags = {
    Name        = "${var.environment}-private-instance"
    Environment = var.environment
  }
}
