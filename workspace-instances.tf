provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "instance" {
  ami = "ami-0150ccaf51ab55a51"
  instance_type = lookup(var.server-type,terraform.workspace)
  count = 3
  key_name = lookup(var.kp-name,terraform.workspace)
  tags = {
    Name = "${lookup(var.insta-name,terraform.workspace)}-${count.index + 1}"
  }
}

