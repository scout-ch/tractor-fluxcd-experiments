
resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this, infomaniak_kaas_instance_pool.instance_pool]


  embedded_manifests     = true
  kustomization_override = file("${path.root}/resources/flux-kustomization-patch.yaml")
  path                   = "clusters/tractor-fluxcd-experiments"
}

// TODO:
// module to create tenant repo
// webhooks
