output "config_repository" {
  description = "The GitHub repository containing the cluster configuration for the shared K8s cluster"
  value       = github_repository.this.name
}

output "config_repository_full_name" {
  description = "The full name of the GitHub repository containing the cluster configuration for the shared K8s cluster"
  value       = github_repository.this.full_name
}

output "k8s_config" {
  description = "The decompose kubeconfig of the managed K8s cluster"
  value       = local.k8s_config
}

output "cluster_info" {
  description = "Basic information about the managed K8s cluster"
  value       = local.cluster_info
}

output "flux_private_key" {
  description = "The private key used by Flux to access the Git repository"
  value       = tls_private_key.flux.private_key_pem
}
