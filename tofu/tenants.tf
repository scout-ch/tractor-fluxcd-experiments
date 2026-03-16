
module "t_whoami" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/tenant"

  cluster_config_repository = module.flux.config_repository
  tenant_name               = "whoami"
  webhook_ingress_host      = local.webhook_host
}

module "ns_pbs_who_is_who_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/namespace"

  name = "pbs-who-is-who"

  providers = {
    kubernetes = kubernetes.emergency-cluster
  }
}
