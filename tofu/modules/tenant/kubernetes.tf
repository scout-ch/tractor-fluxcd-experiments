resource "kubernetes_namespace" "this" {
  metadata {
    name = local.kubernetes_namespace
    labels = {
      "toolkit.fluxcd.io/tenant" = var.tenant_name
    }
  }
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = local.kubernetes_secret_name
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  type = "Opaque"

  data = {
    identity       = tls_private_key.this.private_key_pem
    "identity.pub" = tls_private_key.this.public_key_openssh
    known_hosts    = join("\n", [for key in data.github_ssh_keys.this.keys : "github.com ${key}"])
  }
}
