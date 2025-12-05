resource "github_repository_file" "this" {
  repository = var.config_github_repository
  file       = "${var.config_path}/webhook-receiver.yaml"
  content    = local.webhook_receiver_manifest
}

resource "random_password" "token" {
  length  = 32
  special = false
  lower   = true
  upper   = false
  numeric = true
}

resource "kubernetes_secret" "token" {
  metadata {
    name      = local.webhook_receiver_secret_name
    namespace = var.secret_namespace
  }

  type = "generic"

  data = {
    token = random_password.token.result
  }
}

/* not working with kubewait 0.4.0
resource "kubewait_wait" "webhook_receiver_ready" {
  resource  = "receiver"
  for       = "jsonpath={.status.ready}=true"
  name      = local.webhook_receiver.metadata.name
  namespace = local.webhook_receiver.metadata.namespace
  timeout   = 300
}
*/

data "kubernetes_resource" "this" {
  api_version = local.webhook_receiver.apiVersion
  kind        = local.webhook_receiver.kind
  metadata {
    name      = local.webhook_receiver.metadata.name
    namespace = local.webhook_receiver.metadata.namespace
  }

  depends_on = [
    kubernetes_secret.token,
    //kubewait_wait.webhook_receiver_ready,
  ]
}

resource "github_repository_webhook" "this" {
  repository = var.github_repository
  events = [
    "ping",
    "push",
  ]

  configuration {
    url          = "https://${var.host}${data.kubernetes_resource.this.object.status.webhookPath}"
    secret       = random_password.token.result
    content_type = "form"
  }
}
