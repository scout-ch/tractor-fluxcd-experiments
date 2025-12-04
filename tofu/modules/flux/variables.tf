variable "github_repository" {
  description = "GitHub repository"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "webhook_ingress_host" {
  description = "The host where the webhook receiver will be accessible"
  type        = string
  default     = null
}
