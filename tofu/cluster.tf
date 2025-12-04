module "kaas" {
  source = "./modules/kaas"

  infomaniak_public_cloud = {
    id         = "2976"
    project_id = "36930"
  }

  cluster = {
    name = "tractor-fluxcd-experiments"
  }

  cluster_instance_pools = {
    default = {}
  }
}

module "flux" {
  source = "./modules/flux"

  github_repository = "tractor-fluxcd-experiments-config"
}

module "traefik" {
  source = "./modules/traefik"

  cluster_config_repository = module.flux.config_repository
}
