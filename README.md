# InfrastructureAsCode
DevOps Development Tool Building

## Proxmox credentials

The Proxmox API token is supplied through the sensitive `proxmox_api_token`
Terraform variable, not stored in `provider.tf`. Create a local variable file
from the example and replace the placeholder with your token:

```sh
cp terraform.tfvars.example terraform.tfvars
```

The `.gitignore` rules exclude `*.tfvars` and `*.tfvars.json`, so the local
`terraform.tfvars` will not be added to Git. Keep the example file committed
with only a placeholder. Since a token was previously embedded in the provider
configuration, revoke it in Proxmox and use a newly generated token here.

## Cloud-init

[`cloud-init.yaml`](./cloud-init.yaml) prepares an Ubuntu guest for use as a
Kubernetes worker. It installs the container runtime and QEMU guest agent,
loads the required kernel modules, enables Kubernetes networking sysctls, and
disables swap.

The file intentionally does not contain passwords, SSH keys, or cluster join
tokens. Provide those through a private NoCloud seed or a secret-management
system when creating the VM. Terraform uploads this file to the `Repo` datastore as a Proxmox snippets
file and attaches it through the VM `initialization` block. The current VM
still boots an Ubuntu installer ISO; that ISO does not automatically consume
cloud-init user data as an automated OS installation. Use an Ubuntu
cloud-image/template, or configure Ubuntu Autoinstall separately, for a fully
automated installation.
