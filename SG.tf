resource "aws_security_group" "default_sg" {
  name        = "default"
  description = "default VPC security group"
  vpc_id      = aws_vpc.my_vpc.id
}

resource "aws_security_group_rule" "inbound_rule" {
  security_group_id        = aws_security_group.default_sg.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "sg-0b14def64fc22b5b8"
}

resource "aws_security_group_rule" "outbound_rule" {
  security_group_id = aws_security_group.default_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

