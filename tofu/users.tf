module "u_clever" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=80e0e83e1e2d4c3aff94aa8b68f8d8f906678721" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas.cluster_info
}

module "u_clever_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/user?ref=80e0e83e1e2d4c3aff94aa8b68f8d8f906678721" # main

  username          = "clever"
  default_namespace = null

  cluster_info = module.kaas_emergency.cluster_info

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
