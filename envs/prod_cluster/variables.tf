variable "do_token" {
  type = string
  description = "Access token for DigitalOcean"
}

locals {
  cluster_name = "prod"
  root_hostname = "gdefsolutions.com"
}