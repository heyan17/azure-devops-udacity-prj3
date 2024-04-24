resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZPoOvvQSXaF6f8fosR39aS6tuXjIzdHam/vzjoK+XRhDWhxki3sl8bL+WlGDaOgUtWbxlX2LppWBVGSiVVU0hTfPM3TToC4nbXBlUK0py+UVyYbQYVgvP2mVMT9VzJizzJVN/rRybK8EK5kaNGgjZioDS4iTlAS0J4iBSN7kvFUQ1uktABxDBmax0vNwo6MgUcG0hrFu4UbzHIw5NfPs/+25ehdxTs3356AZeAmBMEbLnGhEkyY0cZGw14wTyrAgu9/hGON/hzH8IemN9/6xgv32RMUWUh7CwH0r9k2RIn29b72iZYSsIsz9FQveDnO4tXpYSf8g2cX9EK/S9yyqttnYNonuca3as1POoPkYIVigavShPwa22us5ujMIA//kIpvtqUK2+GWsmpc2q3AbO8G+DIfEGo67xX1HKsevmuHJ+TH1r04ddo+HAq2DPlbTl8IIdLkzvjG0r9jwVHFWvo7m1WbFZNav5qIIVdc3dVSP9H93/LDOBWs/RGjseS88= devopsagent@anLinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
