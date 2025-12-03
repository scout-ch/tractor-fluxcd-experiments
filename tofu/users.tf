module "u_clever" {
  source = "./modules/user"

  username          = "clever"
  default_namespace = null

  cluster_info = module.flux_cluster.cluster_info
}
