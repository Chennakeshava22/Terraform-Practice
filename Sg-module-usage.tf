module "test" {
  source = "./Security-group"
  vpc_id = "vpc-0f6d109b87e18a10b"
  sg_name = "test-sg"
  protocol_name = "tcp"
  fromport_inbound = 80
  toport_inbound = 80
  cidr_in = ["0.0.0.0/0"]
  proto_in = "tcp"
  fp_ib = 443
  tp_ib = 443
  cidr_ib = ["0.0.0.0/0"]
  proto_out = "-1"
  fp_out = 0
  tp_out = 0
  cidr_out = ["0.0.0.0/0"]
  name = "test-sg"
}

