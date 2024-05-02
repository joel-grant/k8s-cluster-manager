# k8s-cluster-manager
Summary: Creates and updates an AWS EKS cluster of Ruby on Rails microservices using Terraform, Helm, and GitHub Actions.

Once complete, the work in this repository will:
- Serve as an "Infrastructure as Code" (IaC) service that fully automates the creation, customization, and tear down of a development environment within a kubernetes cluster on AWS (also known as EKS).
- Use Terraform, GitHub Actions, and Helm to automate the cluster management.
- User Terraform to manage AWS IAM user access and policies.
- Add and manage additional EKS deployments including:
    - [x] VPC
    - [x] Creating the EKS Cluster itself
    - [x] AWS Redis Elasticache
    - [x] Cluster Autoscaler
    - [ ] Logging aggregation service
    - [x] AWS Certificate management
    - [x] NGINX Ingress
    - [ ] Stats
    - [ ] Ruby/Rails Container Image Setup

#
