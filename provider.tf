provider "aws" {
  region = "us-west-2"
}

provider "proxmox" {
  endpoint  = "https://122.172.246.240:10001/"
  api_token = var.proxmox_api_token
  insecure  = true

  ssh {
    username = "root"
    agent    = true
  }
}