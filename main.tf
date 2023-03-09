provider "aws" {
  access_key = "AKIAQDVUGEICMVD2WSE5"
  secret_key = "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"
  region = var.region
}

resource "aws_s3_bucket" "private" {
  bucket = "my-private-bucket-s3"
  acl    = "private"
}

terraform {
  backend "s3" {
    bucket = "my-private-bucket-s3"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

#=======================================================================

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"

  name               = var.name
  cidr               = var.cidr

  azs                = var.azs

  private_subnets   = var.private_subnets
  public_subnets    = var.public_subnets

  enable_nat_gateway = true
}

#=======================================================================

module "alb" {
  source                     = "terraform-aws-modules/alb/aws"
  version                    = "~> 6.0"

  name                       = var.alb_name
  subnets                    = concat(module.vpc.private_subnets, module.vpc.public_subnets)
  security_groups            = [aws_security_group.my_sg.id]
  vpc_id                     = var.vpc_id
  internal                   = false
  enable_http2               = true
  enable_deletion_protection = false
}

resource "aws_alb_target_group" "target_group" {
  name                       = "my-target-group"
  port                       = 80
  protocol                   = "HTTP"
  vpc_id                     = var.vpc_id

  health_check {
    enabled                  = true
    interval                 = 30
    path                     = "/"
    port                     = "traffic-port"
    protocol                 = "HTTP"
    timeout                  = 10
    unhealthy_threshold      = 2
  }
}

#=======================================================================

resource "aws_security_group" "my_sg" {
  name            = "my-sg"
  vpc_id          = var.vpc_id

  ingress {
    description   = "TLS from VPC"
    from_port     = 80
    to_port       = 80
    protocol      = "tcp"
    cidr_blocks   = [var.cidr]
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }
}

#=======================================================================

resource "aws_db_subnet_group" "default" {
  name                   = "my-subnet-group"
  subnet_ids             = var.sg_subnets
}

resource "aws_db_instance" "my_database" {
  identifier             = "my-DB"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 1
  max_allocated_storage  = 1
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.sg_id]
}

resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t3.micro"
  subnet_id              = element(var.sg_subnets, 0)
  security_groups        = [var.sg_id]
}
