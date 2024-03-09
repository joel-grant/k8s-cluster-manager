terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38"
    }
  }
  cloud {
    organization = "rocky-mountain-chile-man"

    workspaces {
      name = "kubernetes-ops-dev-eks"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "rocky-mountain-chile-man"
    workspaces = {
      name = "kubernetes-ops-dev-vpc"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "dev"
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids               = data.terraform_remove_state.vpc.outputs.private_subnets
  # Not sure what to do with this right now
  # control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::211125552941:user/kube-admin"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}