provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "insta" {
  ami = var.ami-id
  instance_type = var.insta-type
  key_name = var.kp
  count = var.no
  tags = {
    Name = "${var.name}-${count.index + 1}"
  }
}

