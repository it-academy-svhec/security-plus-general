## Overview

OpenVAS is a FOSS vulnerability scanner that we use in a lab. It runs in a fleet of Docker containers. This document provides guidance on how to setup the OpenVAS instances for students.

## Azure VM Specs
- At least this SKU: Standard B2ms (2 vcpus, 8 GiB memory)
- Storage should be at least 32 GB and a premium SSD LRS
- Ensure it is on the same VNet with the Metasploitable targets and student Kali VMs
- The VM should be in a separate resource group like `security-infra` so it is unaffected by the autoshutdown management feature of the ITA Lab Platform.
- Naming conventions can be `student-openvas-<num>`
- Tested with Ubuntu 24

## OpenVAS Setup
