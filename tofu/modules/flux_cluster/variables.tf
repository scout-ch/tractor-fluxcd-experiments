variable "github_repository" {
  description = "GitHub repository"
  type        = string
}

variable "infomaniak_public_cloud_id" {
  description = "Infomaniak public cloud ID"
  type        = string
}

variable "infomaniak_public_cloud_project_id" {
  description = "Infomaniak public cloud project ID"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "tractor-fluxcd-experiments"
}

variable "cluster_region" {
  description = "Region for the Kubernetes cluster"
  type        = string
  default     = "dc4-a"
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
  default     = "1.34"
}

variable "cluster_instance_pool_name" {
  description = "Name of the instance pool for the Kubernetes cluster"
  type        = string
  default     = "default"
}

variable "cluster_instance_pack_name" {
  description = "Pack name for the instance pool"
  type        = string
  default     = "shared"
}

variable "cluster_instance_pool_flavor" {
  description = "Flavor for the instance pool"
  type        = string
  default     = "a1-ram2-disk20-perf1"
}

// Infomaniak doesn't officially support autoscaling yet, so we stick to that for now.
variable "cluster_instance_pool_instances" {
  description = "Number of instances in the instance pool"
  type        = number
  default     = 1
}

variable "cluster_instance_pool_availability_zone" {
  description = "Availability zone for the instance pool"
  type        = string
  default     = "az-1"
}
