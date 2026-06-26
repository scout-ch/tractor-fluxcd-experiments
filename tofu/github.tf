resource "github_repository" "flux-config" {
  name        = "tractor-fluxcd-experiments-config"
  description = "tractor-fluxcd-experiments-config"
  visibility  = "public"
  auto_init   = true # This is extremely important as flux_bootstrap_git will not work without a repository that has been initialised

  topics = [
    "tractor",
  ]
}

module "gateway_api_crds" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/gateway_api_crds?ref=420e24d97c5ec6c314ef6a0180c1ad122916b402" # main

  github_repository = module.flux.config_repository
}

module "traefik" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=420e24d97c5ec6c314ef6a0180c1ad122916b402" # main

  github_repository = module.flux.config_repository
}

module "cert_manager" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=420e24d97c5ec6c314ef6a0180c1ad122916b402" # main

  github_repository = module.flux.config_repository
}

module "metrics_server" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/metrics_server?ref=420e24d97c5ec6c314ef6a0180c1ad122916b402" # main

  github_repository = module.flux.config_repository
}

module "velero" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/velero?ref=420e24d97c5ec6c314ef6a0180c1ad122916b402" # main

  github_repository = module.flux.config_repository
}

module "external_snapshotter" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/external_snapshotter?ref=420e24d97c5ec6c314ef6a0180c1ad122916b402" # main

  github_repository = module.flux.config_repository
}

module "kyverno" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/kyverno?ref=420e24d97c5ec6c314ef6a0180c1ad122916b402" # main

  github_repository = module.flux.config_repository
}
