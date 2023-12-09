provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "mezko-eks"
}

terraform {
  backend "s3" {
    bucket         = "mezkovv-diploma"
    key            = "dev.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform_locks_mezkovv"
  }
}

resource "aws_instance" "jenkins" {
  ami           = var.image_id
  instance_type = "t3.medium"

  key_name = "devops"  

  vpc_security_group_ids = ["sg-02bed5840a3b6210f"]

  tags = {
    Name = "JenkinsServer-mezko-diploma"
    Environment = "dev"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.jenkins.id
  domain   = "vpc"
  tags = {
    Name = "mezko-eip"
    Environment = "dev"
  }
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "mezko-ecr-diploma"
  tags = {
    Environment = "dev"
  }  
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "mezko-node-group"

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
  tags = {
    Environment = "dev"
  }  
}