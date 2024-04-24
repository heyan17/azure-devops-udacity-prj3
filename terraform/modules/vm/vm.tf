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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMzpYqzAaBsCAcBbfvnFMpdT+dAklWbsjpwBlOToxiz/fbFXKhv3aBgdeLxmAVa1qbq1He4y2/gDNcTwsNw1RU32XZ2Goeao9bQ6bFKS27kKlVSojpNatFQ/fjz+2p5Y6fq53+wTAdrdQGq3jhgTIar1PsTbV8fyFF4VUIEC6fuXQFXxFi/i0lrjRavyryTQ9rib1P3ehUQVAsnLHQFZ5t6hjcv09cjC8mGHoDNJMai7SQnwaHzp/ehlWyQ9USxBQBylzUju1v+jdKv1UmKQPg4VhP3dG7qYfAshwSe92rXkEnZ4PqFeszVyAjD3dxzNBhUhKx/Iqc4yR7V7C2mQy2W2L+dPA9PK7U+n/sYXwvAv5M4bLzbVO1Is1dKYe8Iri90xhFP0fhLe0ZLYBG6yvVByMhy+8xcMjSvwjKGdySXrS09fwE3+7ebOg2m2bfJD/h67c9QkXOdQdehADIgIcolGHZxVzJxqOHP1uI6/wD5TZq2eJtdK+iXXOKHUbxa8s= devopsagent@anLinuxVM"
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
