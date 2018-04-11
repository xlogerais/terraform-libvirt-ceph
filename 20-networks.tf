/* Réseaux */

resource "libvirt_network" "management" {
  name      = "${var.prefix}_management"
  bridge    = "${var.prefix}_mgt"
  mode      = "nat"
  dhcp      = { enabled = true }
  addresses = ["10.0.110.0/24"]
  domain    = "${var.prefix}.management"
}

resource "libvirt_network" "storage" {
  name      = "${var.prefix}_storage"
  bridge    = "${var.prefix}_sto"
  mode      = "nat"
  dhcp      = { enabled = true }
  addresses = ["10.0.120.0/24"]
  domain    = "${var.prefix}.storage"
}

