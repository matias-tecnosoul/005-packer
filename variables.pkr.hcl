variable "iso" {
  type        = string
  description = "A URL to the ISO file"
  default     = "https://releases.ubuntu.com/noble/ubuntu-24.04.2-live-server-amd64.iso"
}

variable "checksum" {
  type        = string
  description = "The checksum for the ISO file"
  default     = "sha256:d6dab0c3a657988501b4bd76f1297c053df710e06e0c3aece60dead24f270b4d"
}


variable "name" {
  type        = string
  description = "This is the name of the new virtual machine"
  default     = "mw-ubuntu-server-24.04"
}

variable "username" {
  type        = string
  description = "The username to connect to SSH"
  default     = "ubuntu"
}

variable "password" {
  type        = string
  description = "A plaintext password to authenticate with SSH"
  default     = "ubuntu"
}

variable "guest_os_type" {
  type        = string
  default     = "Ubuntu_64"
}

variable "vm_cpu" {
  type = number
  default = 2
}

variable "vm_memory" {
  type = number
  default = 2048
}

variable "hostname" {
  type    = string
  default = "ubuntu-server"
}
