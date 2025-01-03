variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "public_sg_id" {
  description = "Public Security Group ID"
  type        = string
}

variable "instance_id" {
  description = "Instance ID to attach to target group"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
