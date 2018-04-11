timezone: Europe/Paris

package_update: true
package_upgrade: true

packages:
  - qemu-guest-agent
  - chrony

users:
  - default
  - name: ceph-deploy
    ssh-authorized-keys: "${sshuser}"
    sudo: 'ALL=(ALL) NOPASSWD:ALL'

runcmd:
  - useradd -m -s /bin/bash "ceph-deploy"
  - touch /etc/sudoers.d/ceph-deploy
  - chown root /etc/sudoers.d/ceph-deploy
  - chgrp root /etc/sudoers.d/ceph-deploy
  - chmod 0700 /etc/sudoers.d/ceph-deploy

final_message: "Boot finished at $TIMESTAMP, after $UPTIME seconds"
