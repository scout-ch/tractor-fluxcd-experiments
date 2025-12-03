provider "infomaniak" {
  host = "https://api.infomaniak.com"
}

provider "flux" {
  kubernetes = local.k8s_config
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

provider "github" {
  owner = var.github_org
}

provider "kubernetes" {
  host                   = local.k8s_config_current_context_cluster.server
  client_certificate     = base64decode(local.k8s_config_current_context_user.client-certificate-data)
  client_key             = base64decode(local.k8s_config_current_context_user.client-key-data)
  cluster_ca_certificate = base64decode(local.k8s_config_current_context_cluster.certificate-authority-data)
}
