module "test" {
  source = "./Security-group"
  vpc-id = "vpc-0f6d109b87e18a10b"
  sg-name = "test-sg"
  protocol-name = "tcp"
  fromport-inbound = 80
  toport-inbound = 80
  cidr-in = ["0.0.0.0/0"]
  proto-in = "tcp"
  fp-ib = 443
  tp-ib = 443
  cidr-ib = ["0.0.0.0/0"]
  proto-out = "-1"
  fp-out = 0
  tp-out = 0
  cidr-out = ["0.0.0.0/0"]
  name = "test-sg"
}

