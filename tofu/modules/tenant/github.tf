resource "github_repository" "this" {
  name        = local.github_repository_name
  description = "FluxCD config repository for tenant ${var.tenant_name} on shared K8s cluster of Tractor"
  visibility  = "private"
  auto_init   = true # This is extremely important as flux_bootstrap_git will not work without a repository that has been initialised
}
