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
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/flux?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  cluster_name = local.cluster_name
  github_repository = {
    full_name = github_repository.flux-config.full_name
  }
  webhook_ingress_host = local.webhook_host
}

module "backup_storage" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/backup-storage?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  bucket_name = local.cluster_name
}

module "infrastructure" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cluster_infrastructure?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
  cluster_name              = local.cluster_name
  load_balancer_ip          = "83.228.201.60"

  velero_infomaniak_backup_location = {
    s3_url         = "https://s3.pub2.infomaniak.cloud/"
    s3_credentials = module.backup_storage.credentials
  }
}

module "traefik" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  github_repository = module.flux.config_repository
}

module "cert_manager" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  github_repository = module.flux.config_repository
}

module "metrics_server" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/metrics_server?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  github_repository = module.flux.config_repository
}

module "velero" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/velero?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  github_repository = module.flux.config_repository
}

module "external_snapshotter" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/external_snapshotter?ref=3b328fdc188ba8d3c68144fe273b187e366b9213" # main

  github_repository = module.flux.config_repository
}
