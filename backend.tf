terraform {
  backend "s3" {
    bucket       = "infrastructureascode-remote-state-storage"
    key          = "infrastructureascode/terraform.tfstate"
    encrypt      = true
    use_lockfile = false
    region       = "us-west-2"
  }
}