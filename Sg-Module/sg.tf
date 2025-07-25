resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name = var.sg_name

  ingress {
    protocol = var.protocol_name
    from_port = var.fromport_inbound
    to_port = var.toport_inbound
    cidr_blocks = var.cidr_in
  }
  ingress {
    protocol = var.proto_in
    from_port = var.fp_ib
    to_port = var.tp_ib
    cidr_blocks = var.cidr_ib
  }
  egress {
    protocol = var.proto_out
    from_port = var.fp_out
    to_port = var.tp_out
    cidr_blocks = var.cidr_out
  }
  tags = {
    Name = "${var.name}"
  }

}

