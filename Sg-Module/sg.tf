resource "aws_security_group" "sg" {
  vpc_id = var.vpc-id
  name = var.sg-name

  ingress {
    protocol = var.protocol-name
    from_port = var.fromport-inbound
    to_port = var.toport-inbound
    cidr_blocks = var.cidr-in
  }
  ingress {
    protocol = var.proto-in
    from_port = var.fp-ib
    to_port = var.tp-ib
    cidr_blocks = var.cidr-ib
  }
  egress {
    protocol = var.proto-out
    from_port = var.fp-out
    to_port = var.tp-out
    cidr_blocks = var.cidr-out
  }
  tags = {
    Name = "${var.name}"
  }

}

