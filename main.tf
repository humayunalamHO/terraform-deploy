provider "aws" {
  region     = "us-west-2"
  
  
}

#Create a new EC2 launch configuration
resource "aws_instance" "ec2_prod" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.ssh-security-group.id}"]
  subnet_id                   = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true
  #user_data                   = "${data.template_file.provision.rendered}"
  #iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "EC2-PROD"
  }
  
 
}

resource "aws_instance" "ansible" {
  ami                         = "ami-0e6cf31b6b56b70d7"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.ssh-security-group.id}"]
  subnet_id                   = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true
  #user_data                   = "${data.template_file.provision.rendered}"
  #iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "EC2-ANSIBLE"
  }
  
 
}
#resource "aws_instance" "ec2_private" {
##Create a new EC2 launch configuration
#  ami                         = var.ami_id
#  instance_type               = var.instance_type
#  key_name                    = var.key_name
#  security_groups             = ["${aws_security_group.webserver-security-group.id}"]
#  subnet_id                   = aws_subnet.private-subnet-1.id
#  associate_public_ip_address = false
#  #user_data                   = "${data.template_file.provision.rendered}"
#  #iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
#  lifecycle {
#    create_before_destroy = true
#  }
#  tags = {
#    "Name" = "EC2-PRIVATE"
#  }
# 
#}
################################
