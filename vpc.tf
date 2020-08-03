# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main-vpc"
  }
}

# Subnets
resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "subnet public-${var.AWS_REGION}a"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "subnet public-${var.AWS_REGION}b"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-gw"
  }
}

# route tables
resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "route-public"
  }
}

# route associations public
resource "aws_route_table_association" "route-public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table_association" "route-public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.route-public.id
}
