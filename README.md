# k8s-cluster-manager
Summary: Creates and updates an AWS EKS cluster of Ruby on Rails microservices using Terraform, Helm, and GitHub Actions.

Once complete, the work in this repository will:
- Serve as an "Infrastructure as Code" (IaC) service that fully automates the creation, customization, and tear down of a kubernetes cluster on AWS (also known as EKS).
- Use Terraform, GitHub Actions, and Helm to automate the cluster management.
- User Terraform to manage AWS IAM user access and policies.
- Add and manage additional EKS features such as:
    - [ ] VPC
    - [ ] AWS Redis Elasticache
    - [ ] Cluster Autoscaler
    - [ ] Logging aggregation service
    - [ ] AWS Certificate management
    - [ ] Ingress
    - [ ] Stats

#