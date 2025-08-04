packer {
  required_version = ">= 1.12.0"
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}


source "virtualbox-iso" "basic-ubuntu" {
  guest_os_type     = var.guest_os_type
  vm_name           = var.name
  iso_url           = var.iso
  iso_checksum      = var.checksum
  http_content      = {
    "/user-data"    = templatefile("${path.root}/http/user-data", {
                hostname = var.hostname,
                username = var.username,
                password = bcrypt(var.password)
              })
    "/meta-data"    = ""
  }
  memory     = var.vm_memory
  cpus       = var.vm_cpu
  vrdp_bind_address = "0.0.0.0"
  boot_command      = ["e<wait><down><down><down><end> autoinstall 'ds=nocloud;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'<F10>"]
  gfx_controller = "vmsvga"
  gfx_vram_size = "64"
  boot_wait         = "10s"
  ssh_username      = var.username
  ssh_password      = var.password
  ssh_timeout       = "30m"
  shutdown_command  = "echo '${var.password}' | sudo -S shutdown -P now"
}

build {
  sources = ["source.virtualbox-iso.basic-ubuntu"]

  provisioner "shell" {
    execute_command = "echo '${var.password}' | sudo -S env {{ .Vars }} {{ .Path }}"

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y virtualbox-guest-utils",
      "mkdir -p /home/${var.username}/.ssh",
      "curl -fsSL https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub -o /home/${var.username}/.ssh/authorized_keys",
      "chmod 700 /home/${var.username}/.ssh",
      "mkdir -p /vagrant",
      "chown -R ${var.username}:${var.username} /home/${var.username}/.ssh /vagrant",
      "echo '${var.username} ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/${var.username}"
    ]
  }

  post-processor "vagrant" {
    output = "output/ubuntu-24.04.box"
  }
}