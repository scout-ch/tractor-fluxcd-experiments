variable "name" {
  description = "The name of the webhook"
  type        = string
}

variable "host" {
  description = "The host where the webhook receiver will be accessible"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace where the webhook receiver will be deployed"
  type        = string
}

variable "config_path" {
  description = "The path in the GitHub repository where the webhook configuration is stored"
  type        = string
}

variable "config_github_repository" {
  description = "The GitHub repository where the webhook configuration will be stored"
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository to set up the webhook for"
  type        = string
}

variable "repository_reference" {
  description = "The Git repository reference for Flux to sync from"
  type        = string
}

variable "secret_namespace" {
  description = "Namespace for the kuberenetes_secret resource to prevent bootstrapping race conditions / set up proper terraform depends_on. Usually the same as namespace, but passed in as a property of other modules."
  type        = string
}
