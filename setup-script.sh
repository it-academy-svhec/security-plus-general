#cloud-config
package_update: true
package_upgrade: false

write_files:
  - path: /usr/local/bin/setup-kali.sh
    permissions: '0755'
    owner: root:root
    content: |
      #!/bin/bash
      set -e

      # Add Kali repo and keyring
      wget https://archive.kali.org/archive-keyring.gpg -O /usr/share/keyrings/kali-archive-keyring.gpg
      apt-get update
      apt-get install -y kali-archive-keyring
      apt-get update

      # Install Kali desktop and XRDP dependencies
      apt-get install -y kali-desktop-xfce xrdp dbus-x11 xor
      g

      # Enable and start XRDP services
      systemctl enable --now xrdp xrdp-sesman

      # Setup XFCE session for kali user
      echo "startxfce4" > /home/kali/.xsession
      chmod +x /home/kali/.xsession
      chown kali:kali /home/kali/.xsession

      # Restart XRDP
      systemctl restart xrdp

runcmd:
  - /usr/local/bin/setup-kali.sh
