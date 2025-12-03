resource "random_string" "suffix" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

locals {
  unique_username = "${var.username}-${random_string.suffix.result}"

  template_file = var.default_namespace == null ? "admin-kubeconfig.tftpl" : "kubeconfig.tftpl"
}
