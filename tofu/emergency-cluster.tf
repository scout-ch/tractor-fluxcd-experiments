module "kaas_emergency" {
  source = "./modules/kaas"

  infomaniak_public_cloud = {
    id         = "2976"
    project_id = "34898"
  }

  cluster = {
    name      = "tractor-k8s-emergency"
    version   = "1.35"
    pack_name = "dedicated_4"
    region    = "dc3-a"
  }

  cluster_instance_pools = {
    default = {
      min_instances     = 2
      max_instances     = 2
      availability_zone = "dc3-a-10"
    }
  }
}

module "flux_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/flux?ref=cb1b36eae57388623b2d558a700abe197eea0c70" # main

  cluster_name         = "tractor-k8s-emergency"
  github_repository    = "tractor-k8s-emergency-config"
  webhook_ingress_host = "webhook.emergency.k8s.tractor.scout.ch"

  providers = {
    flux       = flux.emergency-cluster
    kubernetes = kubernetes.emergency-cluster
  }
}

module "traefik_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=cb1b36eae57388623b2d558a700abe197eea0c70" # main

  cluster_config_repository = module.flux_kaas_emergency.config_repository
  cluster_config_path       = module.flux_kaas_emergency.cluster_config_path
  load_balancer_ip          = "195.15.192.244"
}

module "cert_manager_kaas_emergency" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=cb1b36eae57388623b2d558a700abe197eea0c70" # main

  cluster_config_repository = module.flux_kaas_emergency.config_repository
  cluster_config_path       = module.flux_kaas_emergency.cluster_config_path
}

