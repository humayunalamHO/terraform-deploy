# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Devops_VPC"
  }
}

resource "aws_vpc_peering_connection" "vpc" {
  peer_owner_id = 946334840080
  peer_vpc_id   = aws_vpc.vpc.id
  vpc_id        = "vpc-a3e049de"
  auto_accept   = true

  tags = {
    Name = "VPC Peering between jenkins and Devops_VPC"
  }
}
# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Devops-ig"
  }
}
# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.Public_Subnet_1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Devops-public-subnet-1"
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
    Name = "Devops-Public Route Table"
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
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Devops-private-subnet-1"
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

  ingress {
    description = "ICMP ping"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
 } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Devops-SSH Security Group"
  }
}

resource aws_route "centos_jenkins" {
  route_table_id = 	"rtb-0e82b770" //"${aws_route_table.centos-jenkins-rt.id}"
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc.id
}

resource "aws_route53_zone" "devops" {
  name = "devops.local"
  tags = {
    Environment = "prod"
  }  

  vpc {
    vpc_id = aws_vpc.vpc.id
  }
  vpc {
    vpc_id = "vpc-a3e049de"
  }
}

resource "aws_route53_record" "prod1" {
  zone_id = aws_route53_zone.devops.zone_id
  name    = "prod1.devops.local"
  type    = "A"
  ttl     = 300
  records = ["10.0.0.51"]
}

resource "aws_route53_record" "ansible001" {
  zone_id = aws_route53_zone.devops.zone_id
  name    = "ansible001.devops.local"
  type    = "A"
  ttl     = 300
  records = ["10.0.0.52"]
}