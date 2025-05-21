# Security+ Lab - Basic CLI Tools in Kali Linux

## Learning Objectives
- Use common CLI tools in Kali Linux Terminal
- Use common CLI tools in Windows Command Prompt

## CompTIA Objectives
- 4.1 Given a scenario, use the appropriate tool to assess organizational security

## Estimated Time: 1.5 hours

## Required Resources
- Workstation or laptop
- Bootable Kali Linux USB or access to a Kali VM in vCenter

## Overview and Setup

Kali Linux is a distribution that offers many penetration tools.  Kali Linux can be run completely off of a USB without having to actually install it onto a system with Live Boot. This is useful, because as a future hacker, you will want to be able to quickly spin up Kali when you need to attack, and leave no traces that you were ever there.

## Cloud VM Access
1. Review student instructions https://github.com/it-academy-svhec/security-plus-general/blob/main/student_instructions.md

1. You should have access to one Kali Linux VM with a hostname matching the pattern: student-kali-x

1. Log in to the VM with the following credentials
    - Username: ita
    - Password: 820ITAcademy

## Basic Navigation
Before exploring the various penetration tools that Kali has to offer, it’s a good idea to get familiar with some of the common Linux commands.

1. Click the blue Kali icon in the bottom left, select Usual Applications > System > QTerminal

1. The prompt should resemble the following:

    ```bash
    (ita@student--x)-[~]
    ```

1. Your current location is shown inside of the square brackets. In this case, we are in the home directory of the current user which is denoted by the `~` symbol. 

1. To see your current location in full, enter the following command to print the working directory

    ```bash
    pwd
    ```

1. To list the contents of the current directory, enter the following command

    ```bash
    ls
    ```


1. Now switch into the "Documents" directory

   ```bash
    cd Documents
   ```

1. To confirm you are in the `Documents` directory, use a command to print the current working directory


1. If you want to move to the directory one level above the current one, use `..` along with the `cd` command. In our case, we are in `/home/ita/Documents`. Running `cd ..` will take us to `/home/ita`. Run the following

    ```bash
    cd ..
    ```

    **Stop, think:** Linux is case sensitive, which means capitalization matters.

1. In Linux, the root directory is denoted by a single forward slash “/”. The root directory contains all of the files and directories on your linux OS by default. 

1. To change to the root directory, enter the following command

    ```bash
    cd /
    ```

1. Enter the following command to see the contents of the root directory

    ```bash
    ls
    ```

1. Now, switch back to your home directory using the following command

    ```bash
    cd ~
    ```

## Creating Files and Getting Help

1. To create a file in Linux, use the `touch` command followed by the file name:
    ```bash
    touch newfile
    ```

1. Let’s create a new file in our Documents directory. Enter the following:

    ```bash
    touch ~/Documents/myfile.txt
    ```

1. Run the following command to enter some lines of text into the file:

    ```bash
    echo "Look mom, I'm a hacker" >> ~/Documents/myfile.txt
    ```

1. To see the contents of a file, you can use the `cat` command. Run the following:

    ```bash
    cat ~/Documents/myfile.txt
    ```

1. If you are curious about how to use a command, you can refer to its manual page. For example, to view the manual page of the `ls` command, run:

    ```bash
    man ls
    ```

    Within the man page, you are given a description of the command as well as the parameters supported. To exit, press the `Q` key.

1. Parameters are used to modify the behavior of a command. In Linux, parameters usually start with a single dash `-` followed by a letter, or double dashes `--` followed by a word.

1. The `-l` parameter for `ls` will display additional information about files in a directory. Run the following:

    ```bash
    ls -l
    ```

1. To see more straightforward instructions for a command, you can use the `--help` parameter. Run the following:

    ```bash
    ls --help
    ```

1. Some Linux commands require administrator privileges (superuser). To run a command as the superuser, prefix the command with `sudo`.

1. Try running the following command to create a file in the root directory:

    ```bash
    touch /file
    ```

    You should receive a “permission denied” error message.

1. Now, run the command with `sudo`:

    ```bash
    sudo touch /file
    ```

1. Use the `rm` command to delete the `/file`:

    ```bash
    rm /file
    ```

## Linux Network Tools

Your Azure VM is currently connected to a Virtual Network (VNet). This means it can reach other VMs within the same VNet or subnet, but may not have access to external resources such as the Internet or servers in other VNets unless explicitly configured through routing or Network Security Groups (NSGs).

1. To see the network configuration of your VM's adapters, use the `ifconfig` command:
    ```bash
    ifconfig
    ```

    or

    ```bash
    ip addr
    ```

* The names of the network adapters appear on the left (e.g., `lo` for loopback).
* Key fields in the output:

  * `inet`: IPv4 address of the adapter
  * `netmask`: Subnet mask
  * `inet6`: IPv6 address
  * `ether`: MAC address
* Typical adapter names:

  * `eth0` for your Azure VNet interface

1. Determine the IPv4 address assigned by the VNet to your VM.

1. Use the `ping` command to test connectivity between systems in the same VNet. It sends ICMP "echo" requests:

    ```bash
    ping <vm-ip-or-hostname>
    ```

    * Press `CTRL + C` to cancel.
    * To limit pings, use the `-c` parameter:

        ```bash
        ping -c 6 <vm-ip-or-hostname>
        ```
    * To explore additional options, run:

        ```bash
        ping --help
        ```
    * **Task**: Find the parameter for specifying packet size, then run:

        ```bash
        ping -c 5 <parameter> 20 <vm-ip-or-hostname>
        ```

1. Use the `traceroute` command to display the path packets take to a destination VM:

    ```bash
    traceroute <vm-ip-or-hostname>
    ```

   * Use `-n` to skip DNS lookups for faster output:

     ```bash
     traceroute -n <vm-ip-or-hostname>
     ```

1. The `netstat` command displays TCP/IP statistics and active connections:

   * Start SSH on your Azure VM (if not already running):

     ```bash
     sudo service ssh start
     ```
   * Have another user SSH into your VM:

     ```bash
     ssh ita@<vm-ip-or-hostname>
     ```

     * They may need to confirm with `yes`, then enter the password or use an SSH key.
     * The prompt will change to show your VM’s hostname.

1. Have them create a file on your VM to confirm they are connected:

   ```bash
   touch /home/ita/Desktop/success.txt
   ```

1. On your VM, verify that the file exists on the Desktop.

1. Use `netstat` to confirm the SSH connection:

   ```bash
   netstat
   ```

   * Filter for TCP connections:

     ```bash
     netstat -t
     ```
   * Observe:

     * **Foreign address**: The IP of the connecting VM
     * **Local address**: Your Azure VM’s IP
     * Look for the **ssh** label in the connection list.

1. Have the remote user disconnect:

   ```bash
   exit
   ```

1. Use the `arp` command to view the Address Resolution Protocol cache, which maps IP addresses to MAC addresses:

   ```bash
   arp
   ```

   * Confirm that the IP address of the other VM and its MAC address are displayed correctly.

1. The `hping3` tool allows advanced packet crafting and testing:

   * Send TCP packets:

     ```bash
     sudo hping3 <vm-ip-or-hostname>
     ```
   * Send ICMP packets:

     ```bash
     sudo hping3 -1 <vm-ip-or-hostname>
     ```
   * Cancel the command with `CTRL + C`.
   * Spoof your source IP (for testing or simulation only):

     ```bash
     hping3 -a 10.0.0.5 -1 <vm-ip-or-hostname>
     ```

     * You will not receive replies because they are being sent to the spoofed IP address instead of yours.

## Linux Logging Tools

### Head, tail, and logger

Log files store system events and can be used for troubleshooting or investigating security incidents. Linux stores most logs in the `/var/log` directory.

1. To view the contents of the boot log file, use the `cat` command as follows. Troubleshoot the error message you obtain when trying to run the command:
    ```bash
    cat /var/log/boot.log
    ```

1. Log files can get very long. The oldest files are found at the top, and the newest files are found at the bottom.

1. The `head` command displays the first 10 lines of a file. This is useful if you would like to see the oldest logs. Run the following:

    ```bash
    sudo head /var/log/boot.log
    ```

1. By default, head only displays the first 10 lines. To specify how many lines to display, use the `-n` parameter. To see the first 20 lines of the file, run:

    ```bash
    sudo head -n 20 /var/log/boot.log
    ```

1. The `tail` command displays the last 10 lines of a file by default. This is useful if you would like to see the latest entries in a log file. Run the following:

    ```bash
    sudo tail /var/log/boot.log
    ```

1. The tail command supports the `-n` parameter as well; run a command to display the last 15 lines of the `/var/log/boot.log` file.

### Journalctl, logger, and grep

Most modern Linux distributions use the Systemd service manager. The logging service for Systemd is called `journald`.

1. To view `journald` logs, you can use the `journalctl` command:

    ```bash
    journalctl
    ```

    Journalctl only displays a full screen of logs at a time. You can move through the screens by pressing the space key. To exit, press the `Q` key.

1. Let’s display the last 10 lines of output from journalctl using the tail command:

   ```bash
   journalctl | tail
   ```

1. **Stop, think:** The pipe `|` operator sends the output of one command to the input of another. In the previous example, the lengthy output of the journalctl command was sent to the `tail` command which only displays the last 10 lines.

1. The `logger` command can be used to add log entries. It uses the default logging service on a system. Usually, this is syslog, however, Kali doesn’t come with Syslog by default, so it will use `journald`.

1. Run the following command to add a log entry with the text “This is my test log” to journald:

   ```bash
   logger This is my test log
   ```

1. Now, run the following command and ensure your log is displayed:

   ```bash
   journalctl | tail
   ```

1. **Stop, think:** The logger command is useful for scripts as it allows you to log actions that are performed in your script.

1. The `grep` command is used to filter output to only include lines that contain a specific pattern. Let’s filter the output of the `journalctl` command to only include the event where you logged into the system:

   ```bash
   journalctl | grep "session opened for user ita"
   ```

1. Additionally, look for the log where your classmate used ssh to connect to your system. The log will read:

    ```text
    Accepted password for ita from <IP>
    ```

    ```bash
    journalctl | grep "sshd"
    ```

## Permissions

### Overiew
The chmod (change mode) command in Linux is used to modify the permissions of files and directories. These permissions determine who can read, write, or execute a file. Each file or directory has three sets of permissions:

- User (u) – the owner of the file

- Group (g) – members of the file’s group

- Others (o) – all other users on the system

Permissions are represented by letters:

- r = read

- w = write

- x = execute

### Using Chmod
1. Run the following command to create a new file called `permissions.txt`:
    ```bash
    touch permissions.txt
    ```

1. Use the `ls -l` command to display the permissions on files:

    ```bash
    ls -l
    ```

1. Notice the first section of the output for the file. It should resemble the following:

    ```
    -rw-r--r--
    ```

1. The first character is **not** part of the permissions—it represents the file type:

    * `-` means it’s a regular file.
    * `d` would indicate a directory.

1. Permissions are listed in sets of 3 and apply to:

    * The **owner** of the file
    * Members of the **group** that owns the file
    * **Others** (everyone else)

1. Let’s break down the permission string:

    * `rw-` → The owner has **read** and **write** permissions.
    * `r--` → The group has **read-only** permission.
    * `r--` → Others also have **read-only** permission.

1. Use the `chmod` command to modify file permissions.

1. Give the user that owns the file **execute** permissions:

    ```bash
    chmod u+x permissions.txt
    ```

1. Give **others** write permissions to the file:

    ```bash
    chmod o+w permissions.txt
    ```

1. Remove the **write** permissions for **group** members:

        ```bash
        chmod g-w permissions.txt
        ```

1. Run `ls -l` again and ensure the permissions look like this:

    ```
    -rwxr--rw-
    ```

1. Delete the `permissions.txt` file:

    ```bash
    rm permissions.txt
    ```

## Windows Commands
This section covers a few important commands that are useful across Windows and Linux platforms.

Open the command prompt on a Windows system for each of the sections below.

### Ipconfig
The “ipconfig” command displays network information for your adapters. It serves the same purpose on Windows that the `ifconfig` command serves on Linux

1. Run the following command to see basic network info

    ```
    ipconfig
    ```

1. By default, ipconfig leaves out some information such as the MAC address and DNS server addresses. Use the “/all” parameter to display additional information:

    ```
    ipconfig /all
    ```

### Tracert
Tracert serves the same purpose as traceroute but is made for Windows. Run the following to display every router hop your packet goes through to arrive at google.com

```
tracert google.com
```

### Pathping
Pathping combines  the functionality of the ping and tracert commands. It displays all routers a packet goes through to get to a destination. Then, it sends ping packets to each router to compute statistics based on the replies it receives

```
pathping kali.org
```
