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
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/flux?ref=e37ba11e8f4a898bd5d1ed8f6c7e4570296c0e96" # main

  cluster_name         = local.cluster_name
  github_repository    = "tractor-fluxcd-experiments-config"
  webhook_ingress_host = local.webhook_host
}

module "traefik" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=e37ba11e8f4a898bd5d1ed8f6c7e4570296c0e96" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
  load_balancer_ip          = "83.228.201.60"
}

module "cert_manager" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=e37ba11e8f4a898bd5d1ed8f6c7e4570296c0e96" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
}

module "metrics_server" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/metrics_server?ref=e37ba11e8f4a898bd5d1ed8f6c7e4570296c0e96" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
}
