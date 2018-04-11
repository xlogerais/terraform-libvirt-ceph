timezone: Europe/Paris

package_update: true
package_upgrade: true

packages:
  - qemu-guest-agent
  - chrony

users:
  - default
  - name: ceph-deploy
    ssh-authorized-keys: 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFs1Pn1uQwsQWZ9/bZ1QHIflVu5nLiTUE7iCibPHKt5 xavier@work-lab'
    sudo: 'ALL=(ALL) NOPASSWD:ALL'

runcmd:
  - useradd -m -s /bin/bash "ceph-deploy"
  - touch /etc/sudoers.d/ceph-deploy
  - chown root /etc/sudoers.d/ceph-deploy
  - chgrp root /etc/sudoers.d/ceph-deploy
  - chmod 0700 /etc/sudoers.d/ceph-deploy

final_message: "Boot finished at $TIMESTAMP, after $UPTIME seconds"
