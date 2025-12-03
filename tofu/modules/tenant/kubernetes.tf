resource "kubernetes_namespace" "this" {
  metadata {
    name = local.kubernetes_namespace

    labels = {
      "toolkit.fluxcd.io/tenant"              = var.tenant_name
      "kustomize.toolkit.fluxcd.io/name"      = "tenants"     # name of the kustomization managing this namespace see flux_cluster/resources/tenants.yaml
      "kustomize.toolkit.fluxcd.io/namespace" = "flux-system" # namespace of the kustomization managing this namespace flux_cluster/resources/tenants.yaml
    }

    annotations = var.instance_pool != null ? {
      "scheduler.alpha.kubernetes.io/node-selector" = "kaas.infomaniak.cloud/instance-pool=${var.instance_pool}"
    } : null
  }
}

data "github_ssh_keys" "this" {}

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
