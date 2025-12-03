module "t_pbs_taiga" {
  source = "./modules/tenant"

  tenant_name               = "pbs-taiga"
  github_org                = var.github_org
  cluster_config_repository = github_repository.this.name
}
