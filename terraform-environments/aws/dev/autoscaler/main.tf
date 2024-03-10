terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
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
      name = "kubernetes-ops-dev-autoscaler"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

module "eks_k_8_s_cluster_autoscaler" {
  source = "git::git@github.com:gruntwork-io/terraform-aws-eks.git//modules/eks-k8s-cluster-autoscaler?ref=v0.65.6"

  aws_region = "us-west-2"

  eks_cluster_name = "dev"

  iam_role_for_service_accounts_config = object(
    openid_connect_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn,
    openid_connect_provider_url = data.terraform_remote_state.eks.outputs.cluster_oidc_issuer_url
  )
}