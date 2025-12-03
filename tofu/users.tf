module "u_clever" {
  source = "./modules/user"

  username          = "clever"
  default_namespace = module.t_pbs_taiga.namespace

  cluster_info = module.flux_cluster.cluster_info
}
