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
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/flux?ref=e8130e7fa110c4f9969e87f4b3a03bfc952859a6" # main

  cluster_name = local.cluster_name
  github_repository = {
    full_name = github_repository.flux-config.full_name
  }
  webhook_ingress_host = local.webhook_host
}

module "infrastructure" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cluster_infrastructure?ref=e8130e7fa110c4f9969e87f4b3a03bfc952859a6" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
  cluster_name              = local.cluster_name
  load_balancer_ip          = "83.228.201.60"

  velero_infomaniak_backup_location = {
    region_name                 = "dc4-a"
    auth_url                    = "https://api.pub1.infomaniak.cloud/identity"
    application_credential_name = "${local.cluster_name}-velero"
    os_swift_endpoint_host      = "s3.pub2.infomaniak.cloud"
  }
}

module "traefik" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=e8130e7fa110c4f9969e87f4b3a03bfc952859a6" # main

  github_repository = module.flux.config_repository
}

module "cert_manager" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=e8130e7fa110c4f9969e87f4b3a03bfc952859a6" # main

  github_repository = module.flux.config_repository
}

module "metrics_server" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/metrics_server?ref=e8130e7fa110c4f9969e87f4b3a03bfc952859a6" # main

  github_repository = module.flux.config_repository
}

module "velero" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/velero?ref=e8130e7fa110c4f9969e87f4b3a03bfc952859a6" # main

  github_repository = module.flux.config_repository
}

module "external_snapshotter" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/external_snapshotter?ref=e8130e7fa110c4f9969e87f4b3a03bfc952859a6" # main

  github_repository = module.flux.config_repository
}
