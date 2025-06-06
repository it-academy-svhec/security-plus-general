## Overview
Metasploitable 3 is a vulnerable Ubuntu 14.04 OS filled with many legacy, unpatched services. We originally had several VMs with this image hosted in our local vCenter on a VM running Virtual Box. The typical deployment method is to download an *.ova and import it into Virtual Box. Recently, we discovered that we can convert from the *.ova to a *.vhd and deploy in our new Azure security environment.

## Virtual Hard Disk Preparation
The OVA file can be downloaded from https://sourceforge.net/projects/metasploitable3-ub1404upgraded/.

### Basic Process
1. Download the OVA file

1. Extract contents with into a regular folder containing a VMDK file

1. Convert the VMDK file into a VHD file

1. Create a VM in your chosen platform with the virtual disk

### Windows 11 Procedure
1. Download StarWind V2V Converter: https://www.starwindsoftware.com/starwind-v2v-converter

1. Select the VMDK file as a source

1. Select a local destination path

1. Select VHD and then `VHD pre-allocated image`. This ensures that the image is fixed as dynamic virtual disks are not supported in Azure.

There is an option to upload directly to Azure which we have not tested yet.

## Uploading to Azure
The next step is to upload the VHD file to an Azure Storage Container.

1. Create a new storage account with mostly default settings. 

## Reference
Jira ticket: https://svhec.atlassian.net/jira/software/projects/SEC7/boards/7?selectedIssue=SEC7-56
