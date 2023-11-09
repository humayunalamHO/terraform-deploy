provider "aws" {
  region     = "us-west-2"
  
  
}

resource "aws_network_interface" "prod1" {
  subnet_id       = aws_subnet.public-subnet-1.id
  private_ips     = ["10.0.0.51"]
  security_groups = ["${aws_security_group.ssh-security-group.id}"]
}

resource "aws_network_interface" "ansible1" {
  subnet_id       = aws_subnet.public-subnet-1.id
  private_ips     = ["10.0.0.52"]
  security_groups = ["${aws_security_group.ssh-security-group.id}"]
}

#Create a new EC2 launch configuration
resource "aws_instance" "ec2_prod" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  network_interface {
     network_interface_id = "${aws_network_interface.prod1.id}"
     device_index = 0
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "EC2-PROD"
  }
}

resource "aws_instance" "ansible" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  network_interface {
     network_interface_id = "${aws_network_interface.ansible1.id}"
     device_index = 0
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "EC2-ANSIBLE"
  }
}
