## Overview
Terraform is a cloud resource build tool with a declarative syntax, which means you only have to say what you want and not how you want it. *.tf files are used to declare the resource requirements for the cloud environment. We are using Microsoft Azure to host cloud resources for this course.

## Provisioning VMs
1. Log into Azure and open a Cloud Shell

1. Upload the `kali-setup.tf` and `cloud-init-kali.yaml` files to the Cloud Shell

1. Install Terraform if necessary

1. Set the number of VMs in the *.tf file the number of students 

1. Run `terraform init` to initilize Terraform

1. Run `terraform plan` and review the expected resources to be created

1. Run `terraform apply` and enter `yes` to build the resources