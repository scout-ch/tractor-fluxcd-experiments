module "flux_cluster" {
  source = "./modules/flux_cluster"

  infomaniak_public_cloud_project_id = "36930"
  infomaniak_public_cloud_id         = "2976"

  github_repository = "tractor-fluxcd-experiments-config"
}

module "traefik" {
  source = "./modules/traefik"

  cluster_config_repository = module.flux_cluster.config_repository
}
