## Overview
This document covers the setup of Kali VMs in Azure.

## Azure VM Configuration

## Kali Configuration

Kali archive signing keys changed as of April 2025 and must be manually updated on new installations.

1. Update the signing key

    ```bash
    sudo wget https://archive.kali.org/archive-keyring.gpg -O /usr/share/keyrings/kali-archive-keyring.gpg
    ```

1. Update package repos

    ```bash
    sudo apt update
    ```

1. Install xfce GUI

    ```bash
    sudo apt install kali-desktop-xfce -y
    ```

1. Install and enable xrdp

    ```bash
    sudo apt install xrdp -y
    sudo systemctl enable xrdp
    sudo systemctl start xrdp
    ```

1. Make sure `xrdp-sesman` is also running

    ```bash
    sudo systemctl enable xrdp-sesman
    sudo systemctl start xrdp-sesman
    ```

1. Configure `.xsession` for XFCE

    ```bash
    echo startxfce4 > ~/.xsession
    chmod +x ~/.xsession
    ```
### **4. Fix Permissions on TLS Key (if needed)**

If you saw this error before:

```
Cannot read private key file /etc/xrdp/key.pem: Permission denied
```

Fix it by setting correct permissions:

```bash
sudo chown xrdp:xrdp /etc/xrdp/key.pem
sudo chown xrdp:xrdp /etc/xrdp/cert.pem
sudo chmod 600 /etc/xrdp/key.pem
```

Then restart xrdp:

```bash
sudo systemctl restart xrdp
```
