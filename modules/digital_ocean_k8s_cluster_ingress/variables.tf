variable "acme_registration_email_address" {
  type = string
  default = "deforestg@gmail.com"
}
variable "cluster_name" {
  type = string
  description = "The name of the cluster is used to retrieve data about the cluster for auth"
}
variable "do_token" {
  type = string
  description = "Access token for DigitalOcean, required to be passed into acme_certificate"
}
variable "ingress_nginx_version" {
  type = string
  description = "The version of ingress nginx to use"
  default = "4.2.5"
}
variable "root_hostname" {
  type = string
  description = "The root hostname this ingress will listen to. The ingress will also listen to `*.$root_hostname`"
}

locals {
  site_namespace = "site"
  namespace = "ingress-nginx"
  service_name = "ingress-nginx-controller"
  wildcard_hostname = "*.${var.root_hostname}"

  helm_settings = [
    {
      name  = "controller.extraArgs.default-ssl-certificate"
      value = "${kubernetes_namespace.ingress_nginx.metadata.0.name}/${kubernetes_secret.wildcard_tls.metadata.0.name}"
    },
    {
      name  = "controller.addHeaders.Cache-Control"
      value = "no-store\\, no-cache\\, must-revalidate\\, proxy-revalidate\\, max-age=0"
    },
    {
      name  = "controller.addHeaders.X-Content-Type-Options"
      value = "nosniff"
    },
  ]
}