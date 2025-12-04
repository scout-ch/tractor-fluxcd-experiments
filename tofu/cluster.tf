module "kaas" {
  source = "./modules/kaas"

  infomaniak_public_cloud = {
    id         = "2976"
    project_id = "36930"
  }

  cluster = {
    name = local.cluster_name
  }

  cluster_instance_pools = {
    default = {}
  }
}

module "flux" {
  source = "./modules/flux"

  cluster_name         = local.cluster_name
  github_repository    = "tractor-fluxcd-experiments-config"
  webhook_ingress_host = local.webhook_host
}

module "traefik" {
  source = "./modules/traefik"

  cluster_config_repository = module.flux.config_repository
}

resource "infomaniak_record" "traefik" {
  zone_fqdn = "tractor.scout.ch."
  type      = "A"
  source    = "traefik.fluxcd-experiments"
  data = {
    ip = "83.228.202.158" # manually read from service after initial bootstrap
  }
}

resource "infomaniak_record" "webhook_receiver" {
  zone_fqdn = "tractor.scout.ch."
  type      = "CNAME"
  source    = "webhook-receiver.fluxcd-experiments"
  data = {
    target = "traefik.fluxcd-experiments.tractor.scout.ch."
  }
}
