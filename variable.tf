variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     = "ec2-ssh-key"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "devops"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "my-Terraform_ec2-instance"
}
variable "ami_id" {
  description = "AMI for Redhat Ec2 instance"
  default     = "ami-0230bd60aa48260c6"
}


variable "vpc-cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR BLOCK"
  type        = string
}
variable "Public_Subnet_1" {
  default     = "10.0.0.0/24"
  description = "Public_Subnet_1"
  type        = string
}
variable "Private_Subnet_1" {
  default     = "10.0.2.0/24"
  description = "Private_Subnet_1"
  type        = string
}

variable "MY_USER_PUBLIC_KEY" {
  description = "Jenkins user public key."
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkOzVM3nwMHc5lxQyUfAX13TZe/BJQTo2GM0kGTbb9ThQ/wCYli4FWwGkvqnS3KbWDsH80+DmZOYsLAojYj0s6bHKCY1A6hmwvO5VGQgcezI4zuuxQKxHGNCqnr2aWoF4oq2itWunMIJ+DiMUiSvkP4jwMZ5AAwu5boXAzCSj/WGDji8nW1G2tfMQUaeGHGBtm7cvGpYlN2wU75CgB0r3NRP+w4olN+qo1QpUi+tmY5zIrNPTeWrjBLsBMAWCTB5O0hVFyytvOT0uJeVy2en64bg29DGI1LywsSHb5FzmLcmIjL8CEEFbU6a97OpuFkxj6ZOehD0JJB8WHajRDSoCW/pLeMd0JMtDyOY0A9NQjHK5z4b92VzRQdS9aX72xFOkGaVfrJf8DN5StJ9vUmowWcFuLHaxh3LTe3nkysJ0CZXFC1l/OG8LpkQ62SdbE9ZXBRUlrGT3JNJBg6GhG+b3PK5hQQc5OSn3HjDXlth4qbHZ70pQUlUfecvHYpNVVA08= jenkins-key"
}