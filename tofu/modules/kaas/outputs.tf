
output "k8s_config" {
  description = "The decompose kubeconfig of the managed K8s cluster"
  value       = local.k8s_config
}

output "cluster_info" {
  description = "Basic information about the managed K8s cluster"
  value       = local.cluster_info
}
