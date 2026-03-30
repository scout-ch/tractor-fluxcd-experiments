module "kaas" {
  source = "./modules/kaas"

  infomaniak_public_cloud = {
    id         = "2976"
    project_id = "36930"
  }

  cluster = {
    name    = local.cluster_name
    version = "1.35"
  }

  cluster_instance_pools = {
    default = {
      min_instances = 2
      max_instances = 5
    }
  }
}

module "flux" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/flux?ref=060300adad22e4c3af6d63e2caf0262f5b00df4c" # main

  cluster_name         = local.cluster_name
  github_repository    = "tractor-fluxcd-experiments-config"
  webhook_ingress_host = local.webhook_host
}

module "traefik" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=060300adad22e4c3af6d63e2caf0262f5b00df4c" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
  load_balancer_ip          = "83.228.201.60"
}

module "cert_manager" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=060300adad22e4c3af6d63e2caf0262f5b00df4c" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
}

module "metrics_server" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/metrics_server?ref=060300adad22e4c3af6d63e2caf0262f5b00df4c" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
}
