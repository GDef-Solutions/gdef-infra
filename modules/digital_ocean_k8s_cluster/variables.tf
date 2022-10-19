variable "cluster_name" {
  type        = string
  description = "K8s cluster name"
}
variable "cluster_maintenance_policy_start_time" {
  type        = string
  description = "K8s cluster maintenance policy start time"
  default     = "04:00"
}
variable "cluster_maintenance_policy_start_day" {
  type        = string
  description = "K8s cluster maintenance policy start day"
  default     = "sunday"
}
variable "cluster_node_pools" {
  type        = list(object({ name = string, size = string, node_count = number }))
  description = "K8s cluster node pools"
  default     = [
    {
      name       = "worker-pool"
      size       = "s-1vcpu-2gb"
      node_count = 2
    }
  ]
}
variable "cluster_region" {
  type        = string
  description = "K8s cluster region"
  default     = "nyc1"
}
variable "cluster_version_prefix" {
  type        = string
  description = "K8s version prefix, should look like `$MAJOR.$MINOR.`"
  default     = "1.24."
}