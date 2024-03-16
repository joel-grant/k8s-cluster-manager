terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = ">= 0.17.0"
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