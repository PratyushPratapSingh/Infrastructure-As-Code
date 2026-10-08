terraform {
  backend "s3" {
    bucket       = "infrastructureascode-remote-state-storage"
    key          = "infrastructureascode/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
    region       = "us-west-2"
  }
}