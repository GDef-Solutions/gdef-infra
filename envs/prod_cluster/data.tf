data "digitalocean_kubernetes_cluster" "prod" {
  name = "prod"
  depends_on = [module.cluster]
}