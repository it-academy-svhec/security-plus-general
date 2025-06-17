## Overview

OpenVAS is a FOSS vulnerability scanner that we use in a lab. It runs in a fleet of Docker containers. This document provides guidance on how to setup the OpenVAS instances for students.

## Azure VM Specs
- At least this SKU: Standard B2ms (2 vcpus, 8 GiB memory)
- Storage should be 64 GB and a premium SSD LRS
- Ensure it is on the same VNet with the Metasploitable targets and student Kali VMs. You can place it on the infra subnet as well.
- The VM should be in a separate resource group like `security-infra` so it is unaffected by the autoshutdown management feature of the ITA Lab Platform.
- Naming conventions can be `student-openvas-<num>`
- Tested with Ubuntu 24

## OpenVAS Setup
There is a fairly streamlined way to set this up in Docker containers. You can set up the prereqs and then use the setup script or perform the steps manually if anything may need to vary.

1. Review the prereqs section here: https://greenbone.github.io/docs/latest/22.4/container/index.html#prerequisites

1. Complete the steps in the **Install dependencies** and **Installing Docker** sections

1. Then following the steps in https://greenbone.github.io/docs/latest/22.4/container/index.html#prerequisites

1. Once you run the setup script, be patient and wait for the Docker images to download fully.

1. Then you will be prompted to set an admin password. Set the password

1. You will also notice a message about how OpenVAS is loading the CVE feeds now. This can take a long time and is network and CPU intensive and you can check the progress later in the web app.

1. In the Terminal, open the directory that contains the Docker Compose file

1. Run the Docker containers

    ```
    docker compose up -d
    ```

1. Then access the web interface using another VM in the same VNet, unless you installed a GUI for the OpenVAS VM. Access the web interface at http://<open_vas_ip_or_hostname>:9392
