/* Variables */

variable "prefix" { default = "tfceph" }

variable "mon_number" { default = 3 }
variable "osd_number" { default = 3 }

variable "system_pool"    { default = "default" }
variable "data_pool"      { default = "default" }
variable "cloudinit_pool" { default = "default" }

variable "base_image_url" {
  description = "the url to download the base image from"
  default     = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
}

variable "sshpubkey" { default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFs1Pn1uQwsQWZ9/bZ1QHIflVu5nLiTUE7iCibPHKt5 xavier@work-lab" }
variable "sshprivkey" { default = "/home/xavier/.ssh/id_ed25519" }
