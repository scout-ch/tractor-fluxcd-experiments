output "config_repository" {
  description = "The GitHub repository containing the cluster configuration for the shared K8s cluster"
  value       = github_repository.this.name
}

output "config_repository_full_name" {
  description = "The full name of the GitHub repository containing the cluster configuration for the shared K8s cluster"
  value       = github_repository.this.full_name
}

output "flux_private_key" {
  description = "The private key used by Flux to access the Git repository"
  value       = tls_private_key.flux.private_key_pem
}
