module "u_clever" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user"

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas.cluster_info
}
