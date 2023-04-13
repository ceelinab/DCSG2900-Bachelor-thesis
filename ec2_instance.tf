resource "aws_instance" "test_instance"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.instance_key

    network_interface {
        network_interface_id = aws_network_interface.foo.id
        device_index         = 0
    }

    user_data = <<HEREDOC
    #!/bin/bash

    # Update package lists
    sudo yum update -y

    # Install Node.js
    curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
    sudo yum install -y nodejs

    # Install npm
    sudo yum install -y npm
    npm install
    HEREDOC
}