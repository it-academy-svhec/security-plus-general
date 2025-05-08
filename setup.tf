provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "kali" {
  name     = "student-kali"
  location = "East US 2"
}

variable "vm_count" {
  default = 2
}

resource "azurerm_linux_virtual_machine" "kali" {
  count               = var.vm_count
  name                = "student-kali-${count.index + 1}"
  resource_group_name = azurerm_resource_group.kali.name
  location            = azurerm_resource_group.kali.location
  size                = "Standard_B2s"

  admin_username      = "ita"
  admin_password      = "820ITAcademy"

  network_interface_ids = [
    azurerm_network_interface.kali[count.index].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "kali-linux"
    offer     = "kali"
    sku       = "kali"
    version   = "latest"
  }

  custom_data = filebase64("cloud-init-kali.yaml") # Cloud-init script
}
