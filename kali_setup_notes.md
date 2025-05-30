## Overview
This document covers the setup of Kali VMs in Azure.

## Terraform

Ensure that programmatic deployment is configured

![image](https://github.com/user-attachments/assets/11c76ca0-5871-4f69-9abe-fdfda6c5c518)


Accept the image terms for Kali
```bash
az vm image terms accept --urn kali-linux:kali:kali-2024-4:2024.4.1
```

Reference: https://learn.microsoft.com/en-us/marketplace/programmatic-deploy-of-marketplace-products

## Azure VM Configuration

- Operating system/image: Kali 2024.4
- Size: Standard B1s
- VM architecture: x64
- VNet: same as other student VMs
- Subnet: unique subnet for the VM
- Open ports: 22 and 3389

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

1. Restart service
    
    ```bash
    sudo systemctl restart xrdp
    ```
