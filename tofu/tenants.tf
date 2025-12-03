module "t_pbs_taiga" {
  source = "./modules/tenant"

  tenant_name               = "pbs-taiga"
  cluster_config_repository = module.flux_cluster.config_repository
  instance_pool             = "pck-oop98fs-pzm"
}
