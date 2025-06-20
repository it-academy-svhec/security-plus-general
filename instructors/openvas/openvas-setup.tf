provider "azurerm" {
  features {}
  subscription_id = "10150ec8-4a52-423c-a87b-5ccbb4a27cf4" # Update as needed
}

variable "location" {
  default = "East US 2"
}

variable "openvas_resource_group_name" {
  description = "RG to deploy the OpenVAS VMs. Should be different from students."
  default = "security-infra"
}

variable "student_resource_group_name" {
  description = "RG that contains student VMs and shared virtual network."
  default = "student-kali"
}

variable "vnet_name" {
  description = "Same network with student VMs"
  default     = "student-kali-vnet"
}

variable "subnet_name" {
  default = "student-kali-subnet"
}

variable "vm_ids" {
  description = "List of OpenVAS VM instance numbers to deploy"
  type        = list(string)
  default     = ["3"]  # Change this to [1, 2, 3] or [3] as needed
}

resource "azurerm_resource_group" "rg" {
  name     = var.openvas_resource_group_name
  location = var.location
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.student_resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.student_resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = toset(var.vm_ids)
  name                = "nic-openvas-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "openvas_vm" {
  for_each            = toset(var.vm_ids)
  name                = "student-openvas-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2ms"

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  admin_username = "ita"
  admin_password = "820ITAcademy"

  disable_password_authentication = false

  os_disk {
    name                 = "disk-openvas-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = filebase64("cloud-init-openvas.yaml")

  tags = {
    role = "openvas"
  }
}