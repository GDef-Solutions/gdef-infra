# Prod cluster definition

This repo provisions the prod DO cluster

The Access token for DigitalOcean must be provided as a TF variable either during runtime or via the following env var export:
```shell
export TF_VAR_do_token='...'
```