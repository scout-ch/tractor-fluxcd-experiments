terraform {
  backend "pg" {
    conn_str = "postgres://tractor-fluxcd-experiments-tf@postgres.tractor.scout.ch:5432/tractor-fluxcd-experiments-tf?sslmode=disable"
  }
  required_providers {
    infomaniak = {
      source  = "Infomaniak/infomaniak"
      version = "1.3.4"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.7.6"
    }
    github = {
      source  = "integrations/github"
      version = "6.8.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }
}

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
}
