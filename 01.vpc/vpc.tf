resource "aws_vpc" "main" {
  cidr_block = "10.200.0.0/16"

  tags = {
    Name = "SSG-terraform-vpc-changes"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}


resource "aws_subnet" "first_private_subnet" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.200.0.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "first-private-subnet-01"
  }
}

resource "aws_subnet" "second_private_subnet" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.200.1.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "second-private-subnet-02"
  }
}

resource "aws_subnet" "first_public_subnet" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.200.100.0/24"

  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "first-public-subnet-01"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Public-RouteTable"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Private-RouteTable"
  }
}


resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.first_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id      = aws_subnet.first_private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_eip" "NAT_1" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.NAT_1.id

  subnet_id = aws_subnet.first_public_subnet.id

  tags = {
    Name = "NAT-GW-1"
  }
}

resource "aws_route" "private_nat_1" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
}

resource "aws_route" "public_igw" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id 
}



