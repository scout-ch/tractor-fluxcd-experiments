
module "t_whoami" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/tenant?ref=24390f4b7622e18f6a30d3d5e97b3a0c9d919226" # main

  cluster_config_repository = module.flux.config_repository
  tenant_name               = "whoami"
  webhook_ingress_host      = local.webhook_host
}

module "ns_pbs_pfadi_finder_midata_adapter_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/namespace?ref=24390f4b7622e18f6a30d3d5e97b3a0c9d919226" # main

  name = "pbs-pfadi-finder-midata-adapter"

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
