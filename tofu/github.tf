resource "github_repository" "this" {
  name        = var.github_repository
  description = var.github_repository
  visibility  = "private"
  auto_init   = true # This is extremely important as flux_bootstrap_git will not work without a repository that has been initialised
}

resource "tls_private_key" "flux" {
  algorithm = "ED25519"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = github_repository.this.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

// TODO: move to module

resource "tls_private_key" "mova_erinnerungsbuch" {
  algorithm = "ED25519"
}

data "github_ssh_keys" "this" {}

resource "kubernetes_secret" "mova_erinnerungsbuch" {
  metadata {
    name      = "mova-erinnerungsbuch"
    namespace = "mova-erinnerungsbuch"
  }

  type = "Opaque"

  data = {
    identity       = tls_private_key.mova_erinnerungsbuch.private_key_pem
    "identity.pub" = tls_private_key.mova_erinnerungsbuch.public_key_openssh
    known_hosts    = join("\n", [for key in data.github_ssh_keys.this.keys : "github.com ${key}"])
  }
}

resource "github_repository_deploy_key" "mova_erinnerungsbuch" {
  title      = "Flux"
  repository = "mova-erinnerungsbuch.ch"
  key        = tls_private_key.mova_erinnerungsbuch.public_key_openssh
  read_only  = "true"
}

