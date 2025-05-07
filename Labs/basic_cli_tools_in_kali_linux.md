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
1. Refer to Student Instructions - Accessing Azure VMs

1. You should have access to one Kali Linux VM with a hostname matching the pattern: student-kali-x

1. Log in to the VM with the following credentials
    - Username: ita
    - Password: 820ITAcademy

## Basic Navigation
Before exploring the various penetration tools that Kali has to offer, it’s a good idea to get familiar with some of the common Linux commands.

1. Click the blue Kali icon in the top left, search “Terminal”, and open the Terminal Emulator application 

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

1. You should not see any directories displayed. Let’s create a new directory named `Documents`.

    ```bash
    mkdir Documents
    ```

1. Now switch into this directory

1. To confirm you are in the `Documents` directory, use a command to print the current working directory


1. If you want to move to the directory one level above the current one, use `..` along with the `cd` command. In our case, we are in `/home/ita/Documents`. Running `cd ..` will take us to `/home/ita`. Run the following

    ```bash
    cd ..
    ```

    Stop, think: Linux is case sensitive, which means capitalization matters.

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
