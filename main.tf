provider "aws" {
  region     = "us-east-1"
}

//Create dedicated private ip for host
resource "aws_network_interface" "prod1" {
  subnet_id       = aws_subnet.public-subnet-1.id
  private_ips     = ["10.0.0.51"]
  security_groups = ["${aws_security_group.ssh-security-group.id}"]
}

//Decided to not create a separate ansible host
resource "aws_network_interface" "ansible1" {
  subnet_id       = aws_subnet.public-subnet-1.id
  private_ips     = ["10.0.0.52"]
  security_groups = ["${aws_security_group.ssh-security-group.id}"]
}

#Create a new EC2 instance
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

  user_data = <<-EOF
    #!/bin/bash
    yum intall -y vim
    useradd jenkins
    echo "jenkins ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
    mkdir /home/jenkins/.ssh
    touch /home/jenkins/.ssh/authorized_keys
    echo "${var.MY_USER_PUBLIC_KEY}" >> /home/jenkins/.ssh/authorized_keys
    chown -R jenkins:jenkins /home/jenkins/.ssh
    chmod 700 /home/jenkins/.ssh
    chmod 600 /home/jenkins/.ssh/authorized_keys
    EOF
}

//Create s3 bucket
resource "aws_s3_bucket" "s3-dev" {
  bucket = "my-artifact-upload"
  force_destroy = true

  tags = {
    Name        = "DevOps_bucket"
    Environment = "Dev"
  }
}