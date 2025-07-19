resource "aws_security_group" "practice" {
  vpc_id = "vpc-0f6d109b87e18a10b"
  tags = {
    name = "sample-sg"
  }
}

# the above one is only for usage of the sg in the below ingress rules thats it




resource "aws_security_group" "main" {
  vpc_id = "vpc-0f6d109b87e18a10b"
  tags = {
    name = "my-sg"
  }
  ingress {
    description = "adding http port"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"] # allow from any where
  }
  ingress {
    description = "https port"
    protocol = "tcp"
    from_port = 443
    to_port = 443
    security_groups = [aws_security_group.practice.id]
  }


  egress {
    description = "outbound rules"
    protocol = "-1"  # allowing all the port numbers
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"] # allow from anywhere
  }

}

# ec2-instance

variable "name" {
  default = "my-instance"
}

resource "aws_instance" "instance"{
  ami = "ami-0150ccaf51ab55a51"
  instance_type = "t2.micro"
  key_name = "my-kp"
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    name = "${var.name}"
  }
}

