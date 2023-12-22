resource "aws_vpc" "my_vpc" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.0.0/20"
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.32.0/20"
}

resource "aws_subnet" "subnet_c" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.16.0/20"
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "subnet_association_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "subnet_association_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "subnet_association_c" {
  subnet_id      = aws_subnet.subnet_c.id
  route_table_id = aws_route_table.my_route_table.id
}

