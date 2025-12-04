locals {
  webhook_receiver_secret_name = "${var.name}-webhook-receiver-token"
  webhook_receiver_manifest = templatefile("${path.module}/resources/webhook-receiver.tftpl", {
    name        = var.name
    namespace   = var.namespace
    secret_name = local.webhook_receiver_secret_name
    repository  = var.repository_reference
  })
  webhook_receiver = yamldecode(local.webhook_receiver_manifest)
}
