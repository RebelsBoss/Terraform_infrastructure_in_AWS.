variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "my-vpc"
}

variable "region" {
  description = "Name region AWS"
  type        = string
  default     = "eu-west-1"
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  default     = "module.vpc.vpc_id"
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "public_subnets" {
  description = "A list of public subnets1 inside the VPC"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets1 inside the VPC"
  type        = list(string)
  default     = ["10.0.23.0/24", "10.0.24.0/24"]
}

variable "alb_name" {
  description = "Name for Application Load Balancer"
  type        = string
  default     = "my-alb"
}

variable "sg_id" {
  description = "Security group id"
  type        = string
  default     = "aws_security_group.my-sg.id"
}

variable "sg_subnets" {
  description = "A list of private subnets1 inside the VPC"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.23.0/24", "10.0.24.0/24"]
}

