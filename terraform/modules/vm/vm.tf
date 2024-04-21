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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNmFbVNZJ3z98VLcoxPQpGDXcMsa9PuvscFuQfvQdXHks6yM0e2jC7QnaEa/HmrUndaF9NfkuBh+EcUTnpemyBHWl7dZlPXiU25QBlmBfr7D5TWwEf7L1BYKrLDlyY/uJEX70kp3Tacrplg84PJKTrvTHkgoO81FvZziMNx3BY/aiILmGLuk6KO2HKRxksIQj33EqG/8tkJ/E63YKP5zsXLlu8E63FpkZ+znXc18xlZ0c3cdNykZDwuAnm2OFaR6D0hUaCcjo7mYId91QEhU1zxyk/1A+fzB7Zrqz3Gaq0dcpZgaSMQiIMc+zV+0VQLbQOifYY3zJqvfYPRIILUoc1/ZiFnG10jqQJyERIlr63EuuRDsUJ1FVFQG4x75CcwCKHFXxfR9O6UghCJbM4mUcSAlJP/V/B/nBlTboTpMCYVSFtwpI6LAhntiiRCUTFIxnMRFTT8t/jf89Ajp+gQJ1if99u3+0zf2XZDyXNf7849Wn7sw7Chk23X4xoB4n7oa8= devopsagent@anLinuxVM"
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
