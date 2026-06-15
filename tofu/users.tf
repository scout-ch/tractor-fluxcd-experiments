module "u_clever" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=edb6ea50084111cdf1e3bd833adef3133e3c83f7" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas.cluster_info
}

module "u_clever_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=edb6ea50084111cdf1e3bd833adef3133e3c83f7" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas_emergency.cluster_info

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
