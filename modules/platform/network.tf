# VPC
resource "aws_vpc" "primary" {
  cidr_block = var.vpc_cidr
}

# Internet gateway, route, and accociations
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.primary.id
}

resource "aws_route_table" "igwtable" {
  vpc_id = aws_vpc.primary.id
  tags = {
    Name = "public"
  }
}

resource "aws_route" "igwroute" {
  route_table_id         = aws_route_table.igwtable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.igwtable.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.igwtable.id
}

# Subnets
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = var.public_cidr_1
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = var.public_cidr_2
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-b"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = var.private_cidr_1
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = var.private_cidr_2
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private-b"
  }
}