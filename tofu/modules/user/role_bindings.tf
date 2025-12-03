resource "kubernetes_cluster_role_binding_v1" "edit" {
  count = var.default_namespace == null ? 1 : 0

  metadata {
    name = "${var.username}-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"
    name      = local.unique_username
    api_group = "rbac.authorization.k8s.io"
  }
}
