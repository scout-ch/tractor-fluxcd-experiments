terraform {
  backend "pg" {
    conn_str = "postgres://tractor-fluxcd-experiments-tf@postgres.tractor.scout.ch:5432/tractor-fluxcd-experiments-tf?sslmode=disable"
  }
  required_providers {
    infomaniak = {
      source  = "Infomaniak/infomaniak"
      version = "1.4.1"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.8.6"
    }
    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.1.0"
    }
  }
}

locals {
  cluster_name = "tractor-fluxcd-experiments"
  webhook_host = "webhook.fluxcd-experiments.tractor.scout.ch"
}
