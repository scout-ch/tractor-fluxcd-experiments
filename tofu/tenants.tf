
module "t_whoami" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/tenant?ref=47bc537b9a21307b1fb5ed5db31bddd0b02a09de" # main

  cluster_config_repository = module.flux.config_repository
  cluster_name              = local.cluster_name
  tenant_name               = "whoami"
  webhook_ingress_host      = local.webhook_host

  instance_pool = "pck-ukhkrdx-pfa"
}

module "ns_pbs_pfadi_finder_midata_adapter_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/namespace?ref=47bc537b9a21307b1fb5ed5db31bddd0b02a09de" # main

  name = "pbs-pfadi-finder-midata-adapter"

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
