## Overview
This document covers the setup of Kali VMs in Azure.

## Terraform

Ensure that programmatic deployment is configured

![image](https://github.com/user-attachments/assets/11c76ca0-5871-4f69-9abe-fdfda6c5c518)


Terraform scripts are used, but this document is used to cover anything outside of the script.

Accept the image terms for Kali
```bash
az vm image terms accept --urn kali-linux:kali:kali-2024-4:2024.4.1
```

Reference: https://learn.microsoft.com/en-us/marketplace/programmatic-deploy-of-marketplace-products
