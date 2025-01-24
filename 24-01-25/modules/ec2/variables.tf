variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instance will be launched"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EC2 instance will be launched"
  type        = string
}
