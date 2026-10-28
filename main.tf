#resource "aws_s3_bucket" "my_aws_bucket" {
#  bucket = "terraform-test-bucket-newserverdevelopment"
#
#}

resource "proxmox_virtual_environment_file" "cloud_init" {
  content_type = "snippets"
  datastore_id = "Repo"
  node_name    = "pve01"

  source_raw {
    data      = file("${path.module}/cloud-init.yaml")
    file_name = "k8s-worker3-cloud-init.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "my_vm" {
  vm_id         = 105
  name          = "k8s-worker3"
  node_name     = "pve01"
  bios          = "seabios"
  boot_order    = ["scsi0", "ide2", "net0"]
  on_boot       = false
  started       = false
  scsi_hardware = "virtio-scsi-single"

  agent {
    enabled = true
  }

  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
    numa    = false
  }

  memory {
    dedicated = 2048
    floating  = 0
  }

  cdrom {
    file_id   = "Repo:iso/ubuntu-26.04.1-live-server-amd64.iso"
    interface = "ide2"
  }

  disk {
    datastore_id = "Repo"
    interface    = "scsi0"
    size         = 50
    discard      = "on"
    iothread     = true
    ssd          = true
  }

  initialization {
    datastore_id      = "Repo"
    user_data_file_id = proxmox_virtual_environment_file.cloud_init.id
  }

  network_device {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = true
  }
}