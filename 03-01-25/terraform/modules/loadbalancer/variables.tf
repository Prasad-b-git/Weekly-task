output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}
root@terraform:/home/azureuser/terraform/modules/loadbalancer# cat variables.tf
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
