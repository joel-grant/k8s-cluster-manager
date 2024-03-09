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

module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "k8s.dev.plantcoach.com" = {
      comment = "k8s.dev.plantcoach.com"
      tags = {
        env = "dev"
      }
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}