resource "flux_bootstrap_git" "this" {
  depends_on = [
    github_repository_deploy_key.this
  ]

  embedded_manifests     = true
  kustomization_override = file("${path.module}/resources/flux-kustomization-patch.yaml")
  path                   = local.cluster_config_path
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "tractor-fluxcd-experiments"
}
