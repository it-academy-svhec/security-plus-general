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
1. Locate the OVA file and extract the contents with 7Zip

1. Download StarWind V2V Converter: https://www.starwindsoftware.com/starwind-v2v-converter

1. Select the VMDK file as a source

1. Select a local destination path

1. Select VHD and then `VHD pre-allocated image`. This ensures that the image is fixed as dynamic virtual disks are not supported in Azure.

There is an option to upload directly to Azure which we have not tested yet.

## Uploading VHD to Azure
The next step is to upload the VHD file to an Azure Storage Container.

1. Create or use existing storage account. https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview

1. Create or use an existing Container. https://learn.microsoft.com/en-us/azure/storage/blobs/blob-containers-portal

1. Use Azure CLI to upload VHD to the corresponding Container

    ```bash
    az storage blob upload --account-name itavmimages --container-name vm-images --name metasploitable3-ubuntu1404.vhd --type page --file D:\Metasploitable3-ub1404-disk001.vhd
    ```
1. Check the Azure Portal for the uploaded BLOB

## Creating an Azure VM Image

1. Find the URL for the BLOB in the Azure Portal and replace the `<url>` in the command below
    ```bash
    az image create \
      --resource-group <resourceGroup> \
      --name <imageName> \
      --os-type Linux \
      --generation 1 \
      --source "<url>"
    ```

## Creating a VM from the image
Review the basic steps here: https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal

Click See all images and select your image from My images

## Reference
Jira ticket: https://svhec.atlassian.net/jira/software/projects/SEC7/boards/7?selectedIssue=SEC7-56
