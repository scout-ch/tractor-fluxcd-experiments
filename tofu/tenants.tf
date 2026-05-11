
module "t_whoami" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/tenant?ref=9b58cadcf6ef8bf971a157a108ad2a3ada6a0f66" # main

  cluster_config_repository = module.flux.config_repository
  cluster_name              = local.cluster_name
  tenant_name               = "whoami"
  webhook_ingress_host      = local.webhook_host
}

module "ns_pbs_pfadi_finder_midata_adapter_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/namespace?ref=9b58cadcf6ef8bf971a157a108ad2a3ada6a0f66" # main

  name = "pbs-pfadi-finder-midata-adapter"

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
