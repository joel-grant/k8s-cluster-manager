terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.19.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = ">= 0.17.0"
    }
  }

  cloud {
    organization = "rocky-mountain-chile-man"

    workspaces {
      name = "kubernetes-ops-dev-autoscaler"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "terraform_remote_state" "eks" {
  backend = "remote"
  config = {
    organization = "rocky-mountain-chile-man"
    workspaces = {
      name = "kubernetes-ops-dev-eks"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "dev"]
      command     = "aws"
    }
  }
}

module "eks-cluster-autoscaler" {
  source  = "lablabs/eks-cluster-autoscaler/aws"
  version = "2.2.0"

  cluster_identity_oidc_issuer     = data.terraform_remote_state.eks.outputs.oidc_provider
  cluster_identity_oidc_issuer_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn
  cluster_name                     = "dev"
}