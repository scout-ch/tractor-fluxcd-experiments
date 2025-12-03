resource "kubernetes_role_binding_v1" "edit" {
  for_each = var.users

  metadata {
    name      = "${each.key}-admin"
    namespace = local.kubernetes_namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "admin"
  }

  subject {
    kind      = "User"
    name      = each.value
    api_group = "rbac.authorization.k8s.io"
  }
}
