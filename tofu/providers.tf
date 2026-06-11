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

provider "kubernetes" {
  alias = "emergency-cluster"

  host                   = module.kaas_emergency.k8s_config.host
  client_certificate     = module.kaas_emergency.k8s_config.client_certificate
  client_key             = module.kaas_emergency.k8s_config.client_key
  cluster_ca_certificate = module.kaas_emergency.k8s_config.cluster_ca_certificate
}

provider "flux" {
  alias = "emergency-cluster"

  kubernetes = {
    host                   = module.kaas_emergency.k8s_config.host
    client_certificate     = module.kaas_emergency.k8s_config.client_certificate
    client_key             = module.kaas_emergency.k8s_config.client_key
    cluster_ca_certificate = module.kaas_emergency.k8s_config.cluster_ca_certificate
  }
  git = {
    url = "ssh://git@github.com/${module.flux_kaas_emergency.config_repository_full_name}.git"
    ssh = {
      username    = "git"
      private_key = module.flux_kaas_emergency.flux_private_key
    }
  }
}

provider "openstack" {
  tenant_id = "599b3e68d2ad4a58aa1254b277d91931"
  auth_url  = "https://api.pub1.infomaniak.cloud/identity"
  region    = "dc4-a"
}
