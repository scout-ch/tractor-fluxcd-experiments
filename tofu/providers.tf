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
