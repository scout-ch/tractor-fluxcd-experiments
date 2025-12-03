terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">=6.8.3, <7.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.38.0, <3.0.0"
    }
  }
}
