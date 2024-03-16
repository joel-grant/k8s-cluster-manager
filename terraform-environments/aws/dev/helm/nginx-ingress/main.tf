terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
    random = {
      source = "hashicorp/random"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }
  cloud {
    organization = "rocky-mountain-chile-man"

    workspaces {
      name = "kubernetes-ops-dev-ingress-nginx"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "eks-ingress-nginx" {
  source  = "lablabs/eks-ingress-nginx/aws"
  version = "1.2.0"
}