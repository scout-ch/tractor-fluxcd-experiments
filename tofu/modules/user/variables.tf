variable "username" {
  type     = string
  nullable = false
}

variable "cluster_info" {
  type = object({
    name     = string
    endpoint = string
    ca       = string
  })
}

variable "default_namespace" {
  type     = string
  nullable = true
  default  = "default"
}
