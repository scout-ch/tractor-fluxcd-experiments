provider "infomaniak" {
  host = "https://api.infomaniak.com"
}

provider "flux" {
  kubernetes = {
    host                   = module.flux_cluster.k8s_config.host
    client_certificate     = module.flux_cluster.k8s_config.client_certificate
    client_key             = module.flux_cluster.k8s_config.client_key
    cluster_ca_certificate = module.flux_cluster.k8s_config.cluster_ca_certificate
  }
  git = {
    url = "ssh://git@github.com/${module.flux_cluster.config_repository_full_name}.git"
    ssh = {
      username    = "git"
      private_key = module.flux_cluster.flux_private_key
    }
  }
}

provider "github" {
  owner = "scout-ch"
}

provider "kubernetes" {
  host                   = module.flux_cluster.k8s_config.host
  client_certificate     = module.flux_cluster.k8s_config.client_certificate
  client_key             = module.flux_cluster.k8s_config.client_key
  cluster_ca_certificate = module.flux_cluster.k8s_config.cluster_ca_certificate
}
