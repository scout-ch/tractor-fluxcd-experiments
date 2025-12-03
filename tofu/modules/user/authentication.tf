
// TODO: replace with ephemeral, once OpenTofu supports it
resource "tls_private_key" "user-cert" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_cert_request" "user-cert" {
  private_key_pem = tls_private_key.user-cert.private_key_pem

  subject {
    common_name = local.unique_username
    // To add the user to groups, add organization entries here
  }
}

resource "kubernetes_certificate_signing_request_v1" "user-cert" {
  metadata {
    name = "${var.username}-csr"
  }

  spec {
    request = tls_cert_request.user-cert.cert_request_pem

    signer_name = "kubernetes.io/kube-apiserver-client"
    usages      = ["client auth"]
  }

  auto_approve = true
}
