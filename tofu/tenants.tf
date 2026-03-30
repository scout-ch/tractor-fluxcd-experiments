
module "t_whoami" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/tenant?ref=060300adad22e4c3af6d63e2caf0262f5b00df4c" # main

  cluster_config_repository = module.flux.config_repository
  tenant_name               = "whoami"
  webhook_ingress_host      = local.webhook_host
}

module "ns_pbs_pfadi_finder_midata_adapter_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/namespace?ref=060300adad22e4c3af6d63e2caf0262f5b00df4c" # main

  name = "pbs-pfadi-finder-midata-adapter"

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
