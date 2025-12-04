locals {
  raw_k8s_config                     = yamldecode(infomaniak_kaas.fluxcd_experiments.kubeconfig)
  k8s_config_current_context         = [for context in local.raw_k8s_config.contexts : context if context.name == local.raw_k8s_config.current-context][0].context
  k8s_config_current_context_cluster = [for cluster in local.raw_k8s_config.clusters : cluster if cluster.name == local.k8s_config_current_context.cluster][0].cluster
  k8s_config_current_context_user    = [for user in local.raw_k8s_config.users : user if user.name == local.k8s_config_current_context.user][0].user
  k8s_config = {
    host                   = local.k8s_config_current_context_cluster.server
    client_certificate     = base64decode(local.k8s_config_current_context_user.client-certificate-data)
    client_key             = base64decode(local.k8s_config_current_context_user.client-key-data)
    cluster_ca_certificate = base64decode(local.k8s_config_current_context_cluster.certificate-authority-data)
  }
  cluster_info = {
    name     = local.k8s_config_current_context.cluster
    endpoint = local.k8s_config_current_context_cluster.server
    ca       = local.k8s_config.cluster_ca_certificate
  }
}
