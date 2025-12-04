variable "infomaniak_public_cloud" {
  description = "Infomaniak public cloud configuration"
  type = object({
    id         = string
    project_id = string
  })
}

variable "cluster" {
  description = "Kubernetes cluster configuration"
  type = object({
    name      = string
    pack_name = optional(string, "shared")
    version   = optional(string, "1.34")
    region    = optional(string, "dc4-a")
  })
}

variable "cluster_instance_pools" {
  type = map(object({
    flavor_name       = optional(string, "a1-ram2-disk20-perf1")
    instances         = optional(number, 1) // Infomaniak doesn't officially support autoscaling yet, so we stick to that for now.
    availability_zone = optional(string, "az-1")
  }))
}
