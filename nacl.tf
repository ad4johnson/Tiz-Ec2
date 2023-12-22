resource "aws_internet_gateway" "example" {
  vpc_id = "vpc-0bfd35589fab225d1"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.example.id
}

