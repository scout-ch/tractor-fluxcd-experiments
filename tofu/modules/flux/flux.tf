module "webhook" {
  for_each = var.webhook_ingress_host != null ? { "this" = var.webhook_ingress_host } : {}

  source                   = "../flux_webhook"
  config_github_repository = github_repository.this.name
  github_repository        = var.github_repository
  config_path              = local.cluster_config_path
  host                     = each.value
  namespace                = "flux-system"
  name                     = "flux-system"
  repository_reference     = "flux-system"
  secret_namespace         = flux_bootstrap_git.this.namespace
}

resource "flux_bootstrap_git" "this" {
  depends_on = [
    github_repository_deploy_key.this,
    module.webhook.webhook_file,
  ]

  embedded_manifests     = true
  kustomization_override = file("${path.module}/resources/flux-kustomization-patch.yaml")
  path                   = local.cluster_config_path
}
