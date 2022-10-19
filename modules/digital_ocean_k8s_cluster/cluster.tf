data "digitalocean_kubernetes_versions" "cluster" {
  version_prefix = var.cluster_version_prefix
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = var.cluster_name
  region  = var.cluster_region
  version = data.digitalocean_kubernetes_versions.cluster.latest_version

  maintenance_policy {
    day        = var.cluster_maintenance_policy_start_day
    start_time = var.cluster_maintenance_policy_start_time
  }

  dynamic "node_pool" {
    for_each = var.cluster_node_pools
    content {
      name       = node_pool.value["name"]
      size       = node_pool.value["size"]
      node_count = node_pool.value["node_count"]
    }
  }
}