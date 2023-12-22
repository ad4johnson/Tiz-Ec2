resource "aws_vpc_dhcp_options" "example" {
  domain_name         = "eu-west-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
}

resource "aws_vpc_dhcp_options_association" "example" {
  vpc_id          = "vpc-0bfd35589fab225d1"
  dhcp_options_id = aws_vpc_dhcp_options.example.id
}
