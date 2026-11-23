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
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/gateway_api_crds?ref=c5a31f9547bbe3785219d1dbe8e826ae8813dee2" # main

  github_repository = module.flux.config_repository
}

module "traefik" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/traefik?ref=c5a31f9547bbe3785219d1dbe8e826ae8813dee2" # main

  github_repository = module.flux.config_repository
}

module "cert_manager" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/cert_manager?ref=c5a31f9547bbe3785219d1dbe8e826ae8813dee2" # main

  github_repository = module.flux.config_repository
}

module "metrics_server" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/metrics_server?ref=c5a31f9547bbe3785219d1dbe8e826ae8813dee2" # main

  github_repository = module.flux.config_repository
}

module "velero" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/velero?ref=c5a31f9547bbe3785219d1dbe8e826ae8813dee2" # main

  github_repository = module.flux.config_repository
}

module "external_snapshotter" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/external_snapshotter?ref=c5a31f9547bbe3785219d1dbe8e826ae8813dee2" # main

  github_repository = module.flux.config_repository
}

module "kyverno" {
  source = "git::ssh://git@github.com/scout-ch/tractor-k8s-tenants.git//tofu/modules/kyverno?ref=c5a31f9547bbe3785219d1dbe8e826ae8813dee2" # main

  github_repository = module.flux.config_repository
}
