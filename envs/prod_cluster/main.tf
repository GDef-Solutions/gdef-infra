module "cluster" {
  source       = "../../modules/digital_ocean_k8s_cluster"
  cluster_name = local.cluster_name
}

module "ingress" {
  source = "../../modules/digital_ocean_k8s_cluster_ingress"
  cluster_name = module.cluster.cluster_name
  do_token = var.do_token
  root_hostname = local.root_hostname
}
