module "cluster" {
  source       = "../../modules/digital_ocean_k8s_cluster"
  cluster_name = local.cluster_name
}

locals {
  cluster_name = "prod"
}