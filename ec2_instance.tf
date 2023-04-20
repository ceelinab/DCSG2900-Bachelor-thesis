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
        echo "start codedeploy agenet install"
        sudo yum update -y
        sudo yum install -y ruby
        sudo yum install -y aws-cli
        wget https://aws-codedeploy-eu-north-1.s3.eu-north-1.amazonaws.com/latest/install
        chmod +x ./install
        sudo ./install auto
        sudo service codedeploy-agent status
        echo "agent instald"
    EOF
  /*
  #aws-codedeploy-agent
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
/*

aws-codedeploy-eu-north-1

	eu-north-1

  inter net gate way i riktig netverk å asosiere den

  internet gate way

  routing tabel i subent

  wget https://aws-codedeploy-eu-north-1.s3.eu-north-1.amazonaws.com/latest/install

  */