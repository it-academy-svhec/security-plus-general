## Overview
Microsoft Azure Virtual Machines is a cloud service for running and managing virtual machines. Students log in to Azure and can only interact with the VMs they have been assigned for the course.

## Prerequisites
1. Install X2Go Client on your local machine https://wiki.x2go.org/doku.php/download:start
1. Ensure you have ssh by running `ssh -V` in Command Prompt or a Terminal window on your local machine

## Accessing your VM
1. Review the VM credentials:
- Username: `ita`
- Password: `820ITAcademy`

1. Determine the IP address of your VM

1. Open X2Go on your local machine

1. Create a new session
    
    a. Press Ctrl + N
    
    b. Enter a name for the session

    c. Enter the IP address of your VM in the `Host` field

    d. Enter the username in the `Login` field

    e. Under `Session type`, select `LXDE`

    f. Click OK to save the session

1. Double-click the session to start it
