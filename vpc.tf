# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Test_VPC"
  }
}

resource "aws_vpc_peering_connection" "vpc" {
  peer_owner_id = 618488371083
  peer_vpc_id   = aws_vpc.vpc.id
  vpc_id        = "vpc-efab468b"
  auto_accept   = true

  tags = {
    Name = "VPC Peering between jenkins and Test_VPC"
  }
}
# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "internet_gateway"
  }
}
# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.Public_Subnet_1
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}
# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  route {
    cidr_block = "172.31.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc.id
  }
  
   tags = {
    Name = "Public Route Table"
  }
}
# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.Private_Subnet_1
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

# Create Security Group for the Bastion Host aka Jump Box
# terraform aws create security group
resource "aws_security_group" "ssh-security-group" {
  name        = "SSH Security Group"
  description = "Enable SSH access on Port 22"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
 ingress {
    description = "SSH Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }

  ingress {
    description = "SSH Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SSH Security Group"
  }
}

resource aws_route "centos_jenkins" {
  route_table_id = 	"rtb-7d7fb819" //"${aws_route_table.centos-jenkins-rt.id}"
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc.id
}