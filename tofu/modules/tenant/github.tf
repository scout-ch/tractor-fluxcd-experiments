resource "github_repository" "this" {
  name        = local.github_repository_name
  description = "FluxCD config repository for tenant ${var.tenant_name} on shared K8s cluster of Tractor"
  visibility  = "private"
}

// TODO: Bootstrap repo with initial content

resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = github_repository.this.name
  key        = tls_private_key.this.public_key_openssh
  read_only  = "true"
}

resource "github_repository_file" "this" {
  repository = var.cluster_config_repository
  file       = "${local.config_path}/tenant.yaml"
  content = templatefile("${path.module}/resources/tenant.tftpl", {
    tenant_name                  = var.tenant_name
    secret_name                  = local.kubernetes_secret_name
    github_repository_url        = "ssh://git@github.com/${github_repository.this.full_name}.git"
    namespace                    = local.kubernetes_namespace
    default_service_account_name = local.default_service_account_name
    git_repository_crd_name      = local.git_repository_crd_name
    instance_pool                = var.instance_pool
  })
}
