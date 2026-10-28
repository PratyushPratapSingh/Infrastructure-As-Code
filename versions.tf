terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.101"
    }
  }

  required_version = "~> 1.16.0"
}