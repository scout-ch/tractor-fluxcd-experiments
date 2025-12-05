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
    kubewait = {
      source  = "Nuxij/kubewait"
      version = "0.0.4"
    }
  }
}

locals {
  cluster_name = "tractor-fluxcd-experiments"
  webhook_host = trim("${infomaniak_record.webhook_receiver.source}.${infomaniak_record.webhook_receiver.zone_fqdn}", ".")
}
