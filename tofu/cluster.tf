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
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/flux?ref=99f479413ea626998f29d829212a6c7554e87f7b" # main

  cluster_name = local.cluster_name
  github_repository = {
    full_name = github_repository.flux-config.full_name
  }
  webhook_ingress_host = local.webhook_host
}

module "infrastructure" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cluster_infrastructure?ref=99f479413ea626998f29d829212a6c7554e87f7b" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
  cluster_name              = local.cluster_name
  load_balancer_ip          = "83.228.201.60"
}

module "traefik" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=99f479413ea626998f29d829212a6c7554e87f7b" # main

  github_repository = module.flux.config_repository
}

module "cert_manager" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=99f479413ea626998f29d829212a6c7554e87f7b" # main

  github_repository = module.flux.config_repository
}

module "metrics_server" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/metrics_server?ref=99f479413ea626998f29d829212a6c7554e87f7b" # main

  github_repository = module.flux.config_repository
}
