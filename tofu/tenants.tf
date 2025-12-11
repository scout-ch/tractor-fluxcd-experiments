
module "t_whoami" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/tenant"

  cluster_config_repository = module.flux.config_repository
  tenant_name               = "whoami"
  webhook_ingress_host      = local.webhook_host
}
