#----------------------------------------
# VPC
#----------------------------------------
resource "aws_vpc" "VPC_for_deepia" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC_for_deepia"
  }
}

#----------------------------------------
# Public subnet
#----------------------------------------
resource "aws_subnet" "Subnet_for_deepia" {
  vpc_id                  = aws_vpc.VPC_for_deepia.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet_for_deepia"
  }
}

#----------------------------------------
# IGW
#----------------------------------------
resource "aws_internet_gateway" "Gateway_for_deepia" {
  vpc_id = aws_vpc.VPC_for_deepia.id

  tags = {
    Name = "Gateway_for_deepia"
  }
}

#----------------------------------------
# Route table
#----------------------------------------
resource "aws_route_table" "Table_for_deepia" {
  vpc_id = aws_vpc.VPC_for_deepia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Gateway_for_deepia.id
  }

  tags = {
    Name = "Table_for_deepia"
  }
}

#----------------------------------------
# Route table association
#----------------------------------------
resource "aws_route_table_association" "Association_for_deepia_Table" {
  subnet_id      = aws_subnet.Subnet_for_deepia.id
  route_table_id = aws_route_table.Table_for_deepia.id
}

#----------------------------------------
# Security group
#----------------------------------------
resource "aws_security_group" "SecurityGroup_for_deepia" {
  name   = "SecurityGroup_for_deepia"
  vpc_id = aws_vpc.VPC_for_deepia.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "SecurityGroup_for_deepia"
  }
}
