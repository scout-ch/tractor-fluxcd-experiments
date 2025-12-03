output "kubeconfig" {
  value = templatefile("${path.module}/templates/${local.template_file}", {
    server      = var.cluster_info.endpoint
    cluster     = var.cluster_info.name
    cluster_ca  = base64encode(var.cluster_info.ca)
    namespace   = var.default_namespace
    user        = local.unique_username
    client_cert = base64encode(kubernetes_certificate_signing_request_v1.user-cert.certificate)
    client_key  = base64encode(tls_private_key.user-cert.private_key_pem)
  })
  sensitive = true
}

output "unique_username" {
  value = local.unique_username
}
