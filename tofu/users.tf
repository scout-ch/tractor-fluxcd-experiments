module "u_clever" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=03564520b8b771c6b1e333323cdf496270a6e5cc" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas.cluster_info
}

module "u_clever_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=03564520b8b771c6b1e333323cdf496270a6e5cc" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas_emergency.cluster_info

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
