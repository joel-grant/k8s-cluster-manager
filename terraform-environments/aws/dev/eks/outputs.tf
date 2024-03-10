output "cluster_oidc_issuer_url" {
  description = "The cluster's OIDC issuer URL"
  value = module.eks.cluster_oidc_issuer_url
}
output "oidc_provider_arn" {
  description = "The ARN for the OIDC provider"
  value = module.eks.oidc_provider_arn
}
output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value = module.eks.cluster_endpoint
}
output "cluster_version" {
  description = "The cluster_version of the EKS cluster"
  value = module.eks.cluster_version
}
output "cluster_status" {
  description = "The cluster_status of the EKS cluster"
  value = module.eks.cluster_status
}
output "cluster_name" {
  description = "Thcluster_name of the EKS clustere "
  value = module.eks.cluster_name
}
output "cluster_id" {
  description = "cluster_id of the EKS clusterThe "
  value = module.eks.cluster_id
}
output "cluster_iam_role_name" {
  description = "The cluster_iam_role_name of the EKS cluster"
  value = module.eks.cluster_iam_role_name
}
output "cluster_certificate_authority_data" {
  description = "The cluster_certificate_authority_data of the EKS cluster"
  value = module.eks.cluster_certificate_authority_data
}
output "cluster_addons" {
  description = "A list of cluster addons in the EKS cluster"
  value = module.eks.cluster_addons
}