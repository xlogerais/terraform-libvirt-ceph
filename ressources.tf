
/* Volumes */

# Base OS image to use to create a cluster of different nodes
resource "libvirt_volume" "base_image" {
  name   = "${var.prefix}_base_image.qcow2"
  source = "${var.base_image_url}"
}

resource "libvirt_volume" "monitor_system" {
  pool           = "${var.system_pool}"
  name           = "${var.prefix}_monitor_${count.index}_system.qcow2"
  base_volume_id = "${libvirt_volume.base_image.id}"
  count          = "${var.mon_number}"
}

resource "libvirt_volume" "osd_system" {
  name           = "${var.prefix}_osd_${count.index}_system.qcow2"
  base_volume_id = "${libvirt_volume.base_image.id}"
  count          = "${var.osd_number}"
}

resource "libvirt_volume" "osd_data" {
  pool   = "${var.data_pool}"
  format = "raw"
  name   = "${var.prefix}_osd_${count.index}_data.raw"
  size   = 100000000
  count  = "${var.osd_number}"
}

/* Cloud Drives */

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.tpl")}"
  vars = {
    sshuser = "${var.sshuser}"
    sshpubkey = "${var.sshpubkey}"
  }
}

resource "libvirt_cloudinit" "monitor_cloudinit" {
  pool               = "${var.cloudinit_pool}"
  name               = "${var.prefix}_monitor_${count.index}_cloudinit.iso"
  local_hostname     = "${var.prefix}_monitor_${count.index}"
  ssh_authorized_key = "${var.sshpubkey}"
  user_data          = "${data.template_file.user_data.rendered}"
  count              = "${var.mon_number}"
}

resource "libvirt_cloudinit" "osd_cloudinit" {
  pool               = "${var.cloudinit_pool}"
  name               = "${var.prefix}_osd_${count.index}_cloudinit.iso"
  local_hostname     = "${var.prefix}_osd_${count.index}"
  ssh_authorized_key = "${var.sshpubkey}"
  count              = "${var.osd_number}"
}

/* Instances */

resource "libvirt_domain" "monitor" {

  name   = "${var.prefix}_monitor_${count.index}"
  vcpu   = 4
  memory = "4096"
  disk { volume_id = "${element(libvirt_volume.monitor_system.*.id, count.index)}" }
  network_interface { network_name = "${var.prefix}_management" }
  console  { type = "pty"  , target_port = "0" }
  cloudinit = "${element(libvirt_cloudinit.monitor_cloudinit.*.id, count.index)}"
  count = "${var.mon_number}"

}

resource "libvirt_domain" "osd" {

  name   = "${var.prefix}_osd_${count.index}"
  vcpu   = 4
  memory = "4096"
  disk { volume_id = "${element(libvirt_volume.osd_system.*.id, count.index)}" }
  #disk { volume_id = "${element(libvirt_volume.osd_data.*.id, count.index)}" , scsi = true }
  network_interface { network_name = "${var.prefix}_management" }
  console  { type = "pty"  , target_port = "0" }
  cloudinit = "${element(libvirt_cloudinit.osd_cloudinit.*.id, count.index)}"
  count = "${var.osd_number}"

}
