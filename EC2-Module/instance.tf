provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "insta" {
  ami = var.ami_id
  instance_type = var.insta_type
  key_name = var.kp
  count = var.no
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "${var.name}-${count.index + 1}"
  }
}

