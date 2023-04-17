resource "aws_instance" "test_instance" {
  ami                             = var.ami
  instance_type                   = var.instance_type
  key_name                        = var.instance_key
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  network_interface {
    network_interface_id = aws_network_interface.interface_network.id
    device_index         = 0
  }

  tags = {
    "Name" = "test_instance"
  }
#dns hostnames
  user_data = <<-EOF
        #!/bin/bash
        echo "test1"
        echo "test2"
        sudo yum update -y
        echo "test3"
        sudo yum install -y ruby
        sudo yum install -y aws-cli
        sudo yum install -y aws-codedeploy-agent
        sudo service codedeploy-agent status
        echo "test4"
    EOF
  /*
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
    HEREDOC*/
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.ec2-role.name
}