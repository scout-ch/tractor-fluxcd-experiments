module "webhook" {
  for_each = var.webhook_ingress_host != null ? { "this" = var.webhook_ingress_host } : {}

  source                   = "../flux_webhook"
  github_repository        = github_repository.this.name
  config_github_repository = var.cluster_config_repository
  config_path              = local.config_path
  host                     = each.value
  namespace                = local.kubernetes_namespace
  name                     = var.tenant_name
  repository_reference     = local.git_repository_crd_name
  secret_namespace         = kubernetes_namespace.this.metadata[0].name
}
