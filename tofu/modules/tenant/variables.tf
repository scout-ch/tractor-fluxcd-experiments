variable "tenant_name" {
  type = string
}

variable "cluster_config_repository" {
  description = "The GitHub repository containing the cluster configuration for the shared K8s cluster"
  type        = string
}

variable "instance_pool" {
  description = "The instance pool to use for the tenant's workloads"
  type        = string
  nullable    = true
  default     = null
}

variable "users" {
  description = "A map for users that should have access to the tenant's resources"
  type        = map(string)
  default     = {}
}
