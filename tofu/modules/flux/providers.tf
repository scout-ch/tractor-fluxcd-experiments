terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">=1.7.6, <2.0.0"
    }
    github = {
      source  = "integrations/github"
      version = ">=6.8.3, <7.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">=4.1.0, <5.0.0"
    }
  }
}
