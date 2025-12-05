module "t_pbs_taiga" {
  source = "./modules/tenant"

  tenant_name               = "pbs-taiga"
  cluster_config_repository = module.flux.config_repository
  instance_pool             = "pck-e43kobz-pne"
  webhook_ingress_host      = local.webhook_host

  depends_on = [module.flux] # prevent race condition on file creation in the git repository
}
