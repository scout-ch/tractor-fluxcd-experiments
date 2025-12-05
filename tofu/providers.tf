provider "infomaniak" {
  host = "https://api.infomaniak.com"
}

provider "flux" {
  kubernetes = {
    host                   = module.kaas.k8s_config.host
    client_certificate     = module.kaas.k8s_config.client_certificate
    client_key             = module.kaas.k8s_config.client_key
    cluster_ca_certificate = module.kaas.k8s_config.cluster_ca_certificate
  }
  git = {
    url = "ssh://git@github.com/${module.flux.config_repository_full_name}.git"
    ssh = {
      username    = "git"
      private_key = module.flux.flux_private_key
    }
  }
}

provider "github" {
  owner = "scout-ch"
}

provider "kubernetes" {
  host                   = module.kaas.k8s_config.host
  client_certificate     = module.kaas.k8s_config.client_certificate
  client_key             = module.kaas.k8s_config.client_key
  cluster_ca_certificate = module.kaas.k8s_config.cluster_ca_certificate
}

provider "kubewait" {
  kube_config = module.kaas.raw_k8s_config
}
