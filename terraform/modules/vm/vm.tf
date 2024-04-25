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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXn3HaDFKietCG5EgKzILFOTacEiBo/msiUBZQ183966EQPt2e4/2CGgrM76aUrJ21hbyjTPl0v7B62eSXsdL9gmAaqAw7Nx3lIMJ70ZCNBjieXEyGHeiiRcMaRse7I6Gp1/PL3yqmse60VVLgI0nbADgyJV7C5KIhSg3aIQYbgU6u5jrb5i2KLHEvX9Eu5Is4nI7Xt/imjq83SidO16DuRQlHdNVUopIX5RsYyq2N8MabK7wusm9cC7WBsj7E55HsX1FRkW6LTvHeeVHmEg2sBJNjsEnVU9feIKycvZyEeGjalP67ui6ksXq14HVcdiPdw9ylitYR6c7eeFG57dBllo2PXWtG1Wezy5mqG+9kX5ECswLy8d1Y9FSCuX5SNrRDlQmmhDuYZI42DzJ+Xh0ydu+hg/lw9FjYG2UpjLL4u12UHLzY2L1pSPkx084S2qQqpOrGEXYQ2dh4mKGP0caMJb6fNzEAnuna307uIM3QjNygo/8mrmH10n8ovG6hyok= devopsagent@anLinuxVM"
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
