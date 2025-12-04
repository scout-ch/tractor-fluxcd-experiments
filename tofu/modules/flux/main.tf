locals {
  cluster_config_path = "clusters/${var.cluster_name}"
  webhook_ingress_manifest = var.webhook_ingress_host != null ? templatefile("${path.module}/resources/webhook-ingress.tftpl", {
    host = var.webhook_ingress_host
  }) : null
}
