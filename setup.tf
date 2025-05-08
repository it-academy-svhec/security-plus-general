provider "azurerm" {
  features {}
}

variable "vm_count" {
  default = 2
}

resource "azurerm_resource_group" "student_kali" {
  name     = "student-kali"
  location = "East US 2"
}

resource "azurerm_virtual_network" "student_kali_vnet" {
  name                = "student-kali-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.student_kali.location
  resource_group_name = azurerm_resource_group.student_kali.name
}

resource "azurerm_subnet" "student_kali_subnet" {
  name                 = "student-kali-subnet"
  resource_group_name  = azurerm_resource_group.student_kali.name
  virtual_network_name = azurerm_virtual_network.student_kali_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "student_kali_nsg" {
  name                = "student-kali-nsg"
  location            = azurerm_resource_group.student_kali.location
  resource_group_name = azurerm_resource_group.student_kali.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "student_kali_assoc" {
  subnet_id                 = azurerm_subnet.student_kali_subnet.id
  network_security_group_id = azurerm_network_security_group.student_kali_nsg.id
}

resource "azurerm_public_ip" "student_kali_ip" {
  count               = var.vm_count
  name                = "student-kali-ip-${count.index + 1}"
  location            = azurerm_resource_group.student_kali.location
  resource_group_name = azurerm_resource_group.student_kali.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "student_kali_nic" {
  count               = var.vm_count
  name                = "student-kali-nic-${count.index + 1}"
  location            = azurerm_resource_group.student_kali.location
  resource_group_name = azurerm_resource_group.student_kali.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.student_kali_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.student_kali_ip[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "student_kali" {
  count               = var.vm_count
  name                = "student-kali-${count.index + 1}"
  resource_group_name = azurerm_resource_group.student_kali.name
  location            = azurerm_resource_group.student_kali.location
  size                = "Standard_B2s"

  admin_username = "ita"
  admin_password = "820ITAcademy"

  network_interface_ids = [
    azurerm_network_interface.student_kali_nic[count.index].id
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

  custom_data = filebase64("cloud-init-kali.yaml")
}
