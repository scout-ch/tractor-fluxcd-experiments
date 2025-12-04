module "u_clever" {
  source = "./modules/user"

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas.cluster_info
}
