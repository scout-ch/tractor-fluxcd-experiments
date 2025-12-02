
resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this, infomaniak_kaas_instance_pool.instance_pool]


  embedded_manifests = true
  //kustomization_override = templatefile("${path.root}/resources/flux-kustomization-patch.tftpl", { role_arn = var.role_arn })
  path = "clusters/tractor-fluxcd-experiments"
}
