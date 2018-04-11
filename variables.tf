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
