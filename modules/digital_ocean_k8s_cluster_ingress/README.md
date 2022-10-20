# Digital Ocean K8s Cluster Ingress

This repo provisions the [https://kubernetes.github.io/ingress-nginx/](nginx ingress controller),
which creates a DO LB behind the scenes,
root and wildcard domains point to the DO LB,
and the corresponding SSL certs for the domains are created.

In this way, ingresses can be added leveraging subdomains without the overhead of having to manage DNS and SSL with each addition.

A kubernetes namespace 'site' is provisioned which contains a secret for the SSL cert for the root domain.

## `Prerequisites`

Provisioning a digital_ocean_k8s_cluster is a prerequisite to this module.

## Usage

1. Add the following to main.tf:
```terraform
module "ingress" {
  source = "../../modules/digital_ocean_k8s_cluster_ingress"
  root_hostname = local.wildcard_hostname
  cluster_name = module.cluster.cluster_name
}
```
2. Add the following variables to variables.tf:
   1. root_hostname - the desired domain the cluster will own. It will also own the wildcard subdomain.
3. Note that the root cert will be generated into the secret `root-site-tls` in namespace `site`, but will not be applied automatically. Instead, the wildcard cert is the default, and the root site ingress needs to explicitly specify the root site secret for tls.
4. Once merged and applied, you can test the ingress is functional with curl:
```
curl https://asdf.$HOSTNAME

<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
```
