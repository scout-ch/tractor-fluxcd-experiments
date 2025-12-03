
resource "flux_bootstrap_git" "this" {
  depends_on = [
    github_repository_deploy_key.this,
    infomaniak_kaas_instance_pool.instance_pool
  ]


  embedded_manifests     = true
  kustomization_override = file("${path.module}/resources/flux-kustomization-patch.yaml")
  path                   = local.cluster_config_path
}
