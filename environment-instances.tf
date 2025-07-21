provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "instance" {
  ami = "ami-0150ccaf51ab55a51"
  instance_type = lookup(var.server-type,var.env)
  count = 3
  key_name = lookup(var.kp-name,var.env)
  tags = {
    Name = "${lookup(var.insta-name,var.env)}-${count.index + 1}"
  }
}

