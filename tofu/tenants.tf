module "t_pbs_taiga" {
  source = "./modules/tenant"

  tenant_name               = "pbs-taiga"
  cluster_config_repository = module.flux.config_repository
  instance_pool             = "pck-oop98fs-pzm"
}
