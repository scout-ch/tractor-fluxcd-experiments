module "u_clever" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=60eb1836a14d2e1f5afa2d2853fbec60a9fdbf17" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas.cluster_info
}

module "u_clever_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=60eb1836a14d2e1f5afa2d2853fbec60a9fdbf17" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas_emergency.cluster_info

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
