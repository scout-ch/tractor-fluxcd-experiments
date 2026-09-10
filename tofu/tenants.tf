
module "t_whoami" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/tenant?ref=a6f394bf059e47b6b5bcf3a0264e88bed0c93f38" # main

  cluster_config_repository = module.flux.config_repository
  cluster_name              = local.cluster_name
  tenant_name               = "whoami"
  webhook_ingress_host      = local.webhook_host

  instance_pool = "pck-ukhkrdx-pfa"
}

module "ns_pbs_pfadi_finder_midata_adapter_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/namespace?ref=a6f394bf059e47b6b5bcf3a0264e88bed0c93f38" # main

  name = "pbs-pfadi-finder-midata-adapter"

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
