locals {
  config_path                  = "tenants/${var.tenant_name}"
  github_repository_name       = "${var.cluster_config_repository}-${var.tenant_name}"
  kubernetes_namespace         = var.tenant_name
  default_service_account_name = var.tenant_name
  git_repository_crd_name      = var.tenant_name
  kubernetes_secret_name       = "flux-git-deploy-key"
}
