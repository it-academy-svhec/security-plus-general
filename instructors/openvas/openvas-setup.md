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

1. Then following the steps in https://greenbone.github.io/docs/latest/22.4/container/index.html#setup-and-start-script

1. Once you run the setup script, be patient and wait for the Docker images to download fully.

1. Then you will be prompted to set an admin password. Set the password

1. You will also notice a message about how OpenVAS is loading the CVE feeds now. This can take a long time and is network and CPU intensive and you can check the progress later in the web app.

1. In the Terminal, open the directory that contains the Docker Compose file

1. Modify `docker-compose.yml` to contain the following for the `gsa` image. The IP address should be 0.0.0.0 instead of 127.0.0.1 to allow external access.

    Original:
    ```
    127.0.0.1:9392:80
    ```

    Modified
    ```
    0.0.0.0:9392:80
    ```

1. Run the Docker containers

    ```
    docker compose up -d
    ```

1. Then access the web interface using another VM in the same VNet, unless you installed a GUI for the OpenVAS VM. Access the web interface at http://<open_vas_ip_or_hostname>:9392

1. Enter the credentials:
    - Username: `admin`
    - Password: password you set when the containers were first built

## Configure OpenVAS as a Service
If you want to avoid having to start up the containers each time, consider creating a systemd service.

1. Create a new service file `sudo nano /etc/systemd/system/openvas.service`

1. Enter the following contents in the file. Make sure the `WorkingDirectory` path is correct.

    ```
    [Unit]
    Description=OpenVAS Docker Compose
    Requires=docker.service
    After=docker.service
    
    [Service]
    Type=oneshot
    WorkingDirectory=/home/ita/greenbone-community-container
    ExecStart=docker compose up -d
    ExecStop=docker compose down
    RemainAfterExit=yes
    
    [Install]
    WantedBy=multi-user.target
    ```

1. Enable the service

    ```bash
    sudo systemctl enable openvas.service
    ```

1. Restart the VM and confirm that the OpenVAS web server is available

    ```
    sudo shutdown now -r
    ```

## Managing Vulnerability Feeds
OpenVAS imports a large amount of CVE and other vulnerability definitions. This process can take a while to update when you first use OpenVAS. Periodically, OpenVAS will update the feeds and you can check the progress in the web portal.

You can find the status under Administration > Feeds.

If there are issues loading feeds, considering restarting the containers or systemd service if you configured that. Another option is to recreate the images with the previous setup instructions.

Here is some troubleshooting guidance from Greenbone: https://greenbone.github.io/docs/latest/22.4/container/troubleshooting.html

## Troubleshooting
If you forget the admin password, you may need to recreate the containers with the setup script so you can set a new password. The password the web admin user is in the postgres database, but I was unable to find a command to allow me to change this.
