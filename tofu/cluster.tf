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
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/flux?ref=241964fc4faf0f5c465c21c7df8d6d12a4a9ea45" # main

  cluster_name = local.cluster_name
  github_repository = {
    full_name = github_repository.flux-config.full_name
  }
  webhook_ingress_host = local.webhook_host
}

module "backup_storage" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/backup_storage?ref=241964fc4faf0f5c465c21c7df8d6d12a4a9ea45" # main

  bucket_name = local.cluster_name
}

module "infrastructure" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cluster_infrastructure?ref=241964fc4faf0f5c465c21c7df8d6d12a4a9ea45" # main

  cluster_config_repository = module.flux.config_repository
  cluster_config_path       = module.flux.cluster_config_path
  cluster_name              = local.cluster_name
  load_balancer_ip          = "83.228.201.60"
  instance_pool             = "pck-ukhkrdx-pfa"

  velero_infomaniak_backup_location = {
    s3_url         = "https://s3.pub2.infomaniak.cloud/"
    s3_credentials = module.backup_storage.credentials
  }
}
