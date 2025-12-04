resource "github_repository" "this" {
  name        = var.github_repository
  description = var.github_repository
  visibility  = "private"
  auto_init   = true # This is extremely important as flux_bootstrap_git will not work without a repository that has been initialised
}

resource "tls_private_key" "flux" {
  algorithm = "ED25519"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = github_repository.this.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

resource "github_repository_file" "infrastructure" {
  repository = github_repository.this.name
  file       = "${local.cluster_config_path}/infrastructure.yaml"
  content    = file("${path.module}/resources/infrastructure.yaml")
}

resource "github_repository_file" "tenants" {
  repository = github_repository.this.name
  file       = "${local.cluster_config_path}/tenants.yaml"
  content    = file("${path.module}/resources/tenants.yaml")
}

resource "github_repository_file" "webhook_ingress" {
  for_each = local.webhook_ingress_manifest != null ? { "this" = local.webhook_ingress_manifest } : {}

  repository = var.github_repository
  file       = "${local.cluster_config_path}/webhook-ingress.yaml"
  content    = each.value
}
