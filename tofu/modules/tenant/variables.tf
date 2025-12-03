variable "github_org" {
  description = "GitHub organization"
  type        = string
}

variable "tenant_name" {
  type = string
}

variable "cluster_config_repository" {
  description = "The GitHub repository containing the cluster configuration for the shared K8s cluster"
  type        = string
}
