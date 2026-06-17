module "u_clever" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=58bcffd92e2e23a2fdb12c3151ff31efa95f5205" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas.cluster_info
}

module "u_clever_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=58bcffd92e2e23a2fdb12c3151ff31efa95f5205" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas_emergency.cluster_info

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
