provider "aws" {
  region = "us-west-2"
}

terraform {
  cloud {
    organization = "rocky-mountain-chile-man"

    workspaces {
      name = "kubernetes-ops-route53-dev"
    }
  }
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

resource "aws_route53_zone" "private" {
  name = "k8s.dev.plantcoach.com"

  vpc {
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  }

  tags = {
    ManagedBy = "Terraform"
  }
}